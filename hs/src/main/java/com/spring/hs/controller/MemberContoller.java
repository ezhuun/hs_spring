package com.spring.hs.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.spring.hs.Utility;
import com.spring.hs.model.member.MemberConnectDTO;
import com.spring.hs.model.member.MemberDTO;
import com.spring.hs.model.member.MemberService;

@Controller
public class MemberContoller {

	//private static final Logger logger = LoggerFactory.getLogger(MemberContoller.class);
	
	@Autowired
	private MemberService service;
	
	//세션기간 설정
	private int amount = (60 * 60 * 24) * 3;
	//private int amount = 10;

	
	@ResponseBody
	@PostMapping("/deleteMember")
	public Map<String, String> deleteMember(String uuid, String passwd) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "0");
		
		MemberDTO dto = service.getMemberByUuid(uuid);
		boolean pflag = service.passwdCheck(passwd, dto.getPasswd());
		if(pflag == true) {
			//연결을 먼저 끊고..
			Date limit = new Date(System.currentTimeMillis() + (1000*amount));
			service.updateDisconnectStatus(uuid, limit);
			
			//멤버레코드 삭제.. 또는 disabled처리
			boolean flag = service.deleteMember(uuid);
			if(flag) {
				map.put("result", "1");
			}else {
				map.put("result", "2");
			}
		}
		
		return map;
	}
	
	public MemberContoller() {
		super();
	}

	@PostMapping("/disconnect")
	public String disconnect(String uuid) {
		//[member_connect] 그대로유지 대신 limit기간설정과 d_status업데이트
		//[member] c_code 초기화, temp_code다시 발급..
		Date limit = new Date(System.currentTimeMillis() + (1000*amount));
		service.updateDisconnectStatus(uuid, limit);
		return "redirect:/logout";
	}
	
	@ResponseBody
	@PostMapping("/reRegisterPasswd")
	public String reRegisterPasswd(String uuid, String passwd) {
		String result = "0";
		
		boolean flag = service.changePasswd(uuid, passwd);
		if(flag) {
			result = "1";
		}
		
		return result;
	}
	
	@GetMapping("/reRegisterPasswd")
	public String reRegisterPasswd(String uuid, Model model) {
		model.addAttribute("uuid", uuid);
		return "/auth/reRegisterPasswd";
	}
	
	@ResponseBody
	@PostMapping("/forgetPasswdSendMail")
	public String forgetPasswdSendMail(String email) {
		String result = "0";
		
		MemberDTO dto = service.getMemberByEmail(email);
		if(dto != null) {
			String title = "[하트시그널] 비밀번호 변경 안내메일입니다";
			String message = "당신의 하트시그널 비밀번호는 아래 버튼을 통해 재설정이 가능합니다.<br/>"
					+ "만약, 직접 메일을 요청하지 않았거나 비밀번호 재설정을 원치 않으실 경우 해당 메일은 무시해주세요:)<br/>";
			String btnStr = "비밀번호 재설정";
			service.sendMail(email, title, message, "/reRegisterPasswd?uuid="+dto.getUuid(), btnStr);
			result = "1";
		}
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/getCode")
	public String getCcodebyUuid(String uuid) {
		return service.getCcodebyUuid(uuid);
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) {
		
		//쿠키 및 세션 초기화
		Object obj = session.getAttribute("member");
		
		if(obj != null) {
			MemberDTO dto = (MemberDTO)obj;
			session.removeAttribute("member");
			session.invalidate();
			
			Cookie cookieLogin = WebUtils.getCookie(request, "cookieLogin");
			if(cookieLogin != null) {
				cookieLogin.setPath("/");
				cookieLogin.setMaxAge(0);
				response.addCookie(cookieLogin);
				service.keepLogin(dto.getUuid(), "none", new Date());
			}
		}
		
		return "redirect:/login";
	}
	
	@ResponseBody
	@PostMapping("/loginProc")
	public Map<String, String> loginProc(
			String email, 
			String passwd,
			@RequestParam(value="isLogin", required=false, defaultValue="n") String isLogin,
			HttpSession session,
			HttpServletResponse response) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "0");

		//session 초기화
		if ( session.getAttribute("member") != null ){
			session.removeAttribute("member");
		}
		
		MemberDTO dto = service.getMemberByEmail(email);
		if(dto != null) {
			//계정정보가 존재한다면
			boolean pflag = service.passwdCheck(passwd, dto.getPasswd());
			
			if(pflag == true) {
				//비밀번호가 일치한다면..
				dto.setPasswd(null);
				
				//관리자계정일경우
				if(dto.getLev() == 1) {
					service.lastLoginUpdate(dto.getUuid());
					//유저 uuid 세션 기록
					session.setMaxInactiveInterval(amount);
					session.setAttribute("member", dto);
					
					//자동로그인 체크시 쿠키 데이터 저장
					if(isLogin.equals("y")) {
						Cookie cookie = new Cookie("cookieLogin", session.getId());
						cookie.setMaxAge(amount);
						cookie.setPath("/");
						response.addCookie(cookie);
						
						Date session_limit = new Date(System.currentTimeMillis() + (1000*amount));
						service.keepLogin(dto.getUuid(), session.getId(), session_limit);
					}
					
					//로그인 성공
					map.put("result", "1");
				}else {
					//일반계정인 경우
					
					//계정연결에 했는지..
					boolean tflag = true;
					if(dto.getC_code() != null) {
						//계정연결이 되었있는 경우
						MemberConnectDTO cdto = service.getCode(dto.getC_code());
						
						//c_code의 d_status가 0이면서 d_limit이 설정되어있는지 확인한다.
						if(cdto.getD_status().equals("0") && cdto.getD_limit() != null) {
							//만약 limit이 초과되었다면 계정연결해제를 한다
							long diff = Utility.validDiffTime(cdto.getD_limit());
							if(diff >= 0) {
								Date limit = new Date(System.currentTimeMillis() + (1000*amount));
								service.updateDisconnectStatus(dto.getUuid(), limit);
								map.put("result", "5");
								tflag = false;
							}
						}
					}
					
					if(dto.getC_code() == null) {
						//계정연결 페이지 이동
						map.put("uuid", dto.getUuid());
						map.put("code", dto.getTemp_code());
						map.put("result", "3");
					}else if(dto.getName() == null) {
						//프로필입력페이지 이동
						map.put("uuid", dto.getUuid());
						map.put("result", "4");
					}else if(tflag == true){
						//문제없다면
						//로그인 성공
						service.lastLoginUpdate(dto.getUuid());
						
						//연결된 계정정보를 가져온다..
						dto.setLover(service.getConnectedAccount(dto.getUuid()));
						dto.setConnect(service.getCode(dto.getC_code()));
						

						//유저 uuid 세션 기록
						session.setMaxInactiveInterval(amount);
						session.setAttribute("member", dto);
						
						//자동로그인 체크시 쿠키 데이터 저장
						if(isLogin.equals("y")) {
							Cookie cookie = new Cookie("cookieLogin", session.getId());
							cookie.setMaxAge(amount);
							cookie.setPath("/");
							response.addCookie(cookie);
							
							Date session_limit = new Date(System.currentTimeMillis() + (1000*amount));
							service.keepLogin(dto.getUuid(), session.getId(), session_limit);
						}
						
						//로그인 성공
						map.put("result", "1");
					
					}
				
				

				}
			}else {
				//비밀번호가 일치하지 않는다면
				map.put("result", "2");
			}
			
		}
		
		//return value
		//"0" => 회원정보 없음
		//"1" => 로그인성공
		//"2" => 비밀번호 불일치
		//"3" => 계정연결페이지이동
		//"4" => 프로필입력페이지 이동
		//"5" => 계정연결 유효기간 만료
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/updateProfile")
	public String updateProfile(MemberDTO dto,
			HttpSession session) {
		String result = "0";
		
		if(service.updateProfile(dto)) {

			//session 초기화
			if ( session.getAttribute("member") != null ){
				session.removeAttribute("member");
			}
			
			//dto의 getuuid로 dto를 다시 가져온다
			dto = service.getMemberByUuid(dto.getUuid());
			dto.setPasswd(null);
			service.lastLoginUpdate(dto.getUuid());
			dto.setLover(service.getConnectedAccount(dto.getUuid()));
			dto.setConnect(service.getCode(dto.getC_code()));

			session.setMaxInactiveInterval(amount);
			session.setAttribute("member", dto);
			
			result = "1";
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/upload/uploadAjax", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public String uploadAjax(HttpServletRequest request,
			MultipartFile file, 
			@RequestParam String uuid) throws Exception{
		String result = "0";
		
		@SuppressWarnings("deprecation")
		String basePath = request.getRealPath("/resources/upload/profile");
		if(file.getContentType().indexOf("image") >= 0) {
			String fileName = Utility.saveFileSpring(file, basePath);
			
			if(fileName != null) {
				MemberDTO dto = service.getMemberByUuid(uuid);
				if(service.updatePhoto(uuid, fileName)) {
					if(dto.getProfile() != null) {
						//기존내용이 있따면 삭제
						Utility.deleteFile(basePath, dto.getProfile());
					}
					result = fileName;
				}
			}
		}

		
		return result;
	}
	
	@RequestMapping("/profile")
	public String profile(@RequestParam String uuid, Model model) {
		MemberDTO dto = service.getMemberByUuid(uuid);
		model.addAttribute("uuid", dto.getUuid());
		model.addAttribute("profile", dto.getProfile());
		return "/auth/register_profile";
	}
	
	
	@ResponseBody
	@PostMapping("/registerCode")
	public Map<String, String> registerCode(String uuid, String code) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "0");
		map.put("msg", "code is null");
		
		MemberConnectDTO dto = service.getCode(code);
		if(dto != null) {
			if(dto.getC_code().equals("00000000")) {
				map.put("result", "5");
				map.put("msg", "관리자전용 코드입니다");
			}else if(dto.getU1().equals(uuid)) {
				map.put("result", "2");
				map.put("msg", "자신의 초대코드는 등록할 수 없습니다");
			}else {
				boolean validCode = service.validCode(dto.getU1());
				if(validCode == false && (dto.getU2() == null) ){
					boolean flag = service.resigerConnect(uuid, code);
					if(flag == true) {
						map.put("result", "1");
						map.put("msg", "연결성공");
						map.put("uuid", uuid);
					}else {
						map.put("result", "4");
						map.put("msg", "DB error");	
					}
					//연결 service.connect
				}else {
					map.put("result", "3");
					map.put("msg", "초대코드가 만료되었습니다");
				}
			}
		}
		return map;
	}
	
	@ResponseBody
	@PostMapping("/sendEmail")
	public String sendEmail(String email, String code) {
		String title = "[하트시그널] 상대방에게서 초대코드가 도착했습니다";
		String message = "하트시그널로 당신을 초대합니다.<br/>당신의 친구에게서 하트시그널 초대장이 도착했습니다.<br/>"
				+ "상대방과의 계정연결을 원하실 경우 아래 초대코드를 홈페이지 가입 후 입력해주세요"
				+ "<h3>" + code + "</h3>";
		String btnStr = "홈페이지 바로가기";
		int res = service.sendMail(email, title, message, "/register", btnStr);
		if(res == 1) {
			return "1";
		}else {
			return "0";
		}
	}
	
	@PostMapping("/connect")
	public String connect(
			@RequestParam String uuid,
			@RequestParam String code,
			Model model
			) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("code", code);
		
		return "/auth/register_connect";
	}
	
	@ResponseBody
	@PostMapping("/register")
	public Map<String, String> register(MemberDTO dto) throws Exception {
		
		boolean valid = service.duplicateEmail(dto.getEmail());
		Map<String, String> map = new HashMap<String, String>();
		
		if(valid == true) {
			//이메일 중복
			map.put("result", "0");
			map.put("msg", "이메일 중복");
		}else {
			map = service.registerMember(dto.getEmail(), dto.getPasswd());
			if(map != null) {
				//회원가입 성공
				map.put("result", "1");
				map.put("msg", "회원가입 성공");
			}else {
				//회원가입 실패
				map = new HashMap<String, String>();
				map.put("result", "2");
				map.put("msg", "회원가입 실패");
			}
		}
		
		return map;
	}

	@GetMapping("/register")
	public String register() {
		return "/auth/register";
	}
	
	@GetMapping({"/", "/login"})
	public String login() {
		return "/auth/login";
	}
	
	@GetMapping("/main")
	public String main() {
		return "index";
	}

	@GetMapping("/accountSetting")
	public String accountSetting() {
		return "auth/accountSetting";
	}
	
}
