package com.spring.hs.model.member;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.hs.MailHandler;
import com.spring.hs.Utility;
import com.spring.hs.mapper.MemberMapperInter;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapperInter mapper;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender mailSender;

	@Transactional
	@Override
	public boolean deleteMember(String uuid) {
		boolean flag = false;
		MemberDTO dto = getMemberByUuid(uuid);
		
		try {
			mapper.deleteMember(dto.getUuid());
			mapper.deleteCode(dto.getTemp_code());
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	@Transactional
	@Override
	public boolean updateDisconnectStatus(String uuid, Date limit) {
		boolean flag = false;
		MemberDTO dto = getMemberByUuid(uuid);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", dto.getUuid());
		map.put("code", dto.getC_code());
		map.put("d_limit", limit);
		
		if(dto != null) {
		
			try {
				//[MEMBER_CONNECT] disabled status 변경
				mapper.disconnectMemberConnect(map);
		
				//TEMP_CODE와 C_CODE를 비교한다..
				//둘 중 누구의 코드로 연결되었는지 확인..
				//최적화를 위함...
				if(dto.getC_code().equals(dto.getTemp_code())) {
					//만약 같다면.. 내 코드로 연결되어있는상태
					//즉, MEMBER_CONNECT U1은 나 자신
					
					//상대방 정보 _dto
					MemberDTO _dto = getConnectedAccount(dto.getUuid());
					if(_dto != null && _dto.getC_code() != null) {
						//[MEMBER_CONNECT] U2 -> U1, U2 == NULL ...UPDATE
						mapper.changeMemberConnectUUID(dto.getC_code());
						//상대방의 기존 TEMP_CODE [MEMBER_CONNECT]는 삭제..
						mapper.deleteCode(_dto.getTemp_code());
						//상대방의 [MEMBER] C_CODE -> TEMP_CODE로 변경
						mapper.tempCodeChange(_dto.getUuid());
					}else {
						//상대방이 연결을 먼저끊었다면..
						//기존 code disabled
						mapper.disabledCode(dto.getC_code());
					}

					//TEMP_CODE 다시 발급..
					List<String> list = mapper.getAllcode();
					String c_code = Utility.randomKey(list, 8);
					
					Map<String, String> _map = new HashMap<String, String>();
					_map.put("uuid", dto.getUuid());
					_map.put("code", c_code);
					
					//[MEMBER_CONNECT] C_CODE 입력
					mapper.createMemberConnect(_map);
					//[MEMBER] C_CODE 초기화, TEMP_CODE업데이트
					mapper.disconnectMember(_map);
				}else {
					//같지 않다면
					//상대방 코드로 연결되어있는 상태
					
					//MEMBER_CONNECT U2는 나자신이기 때문에 삭제
					mapper.deleteMemberConnectU2(dto.getC_code());
					//내 temp_code는 아직 사용하지 않았기 때문에
					//code를 다시 발급받을 필요가 없다. 기존C_CODE만 초기화
					mapper.clearCcode(dto.getUuid());
				}
				
				flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	// end of if(dto!=null)
		
		return flag;
	}

	@Override
	public boolean changePasswd(String uuid, String passwd) {
		boolean flag = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("uuid", uuid);
		map.put("passwd", passwordEncoder.encode(passwd));
		
		int cnt = mapper.changePasswd(map);
		if(cnt>0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public String getCcodebyUuid(String uuid) {
		return mapper.getCcodebyUuid(uuid);
	}

	@Override
	public MemberDTO checkMemberWithSessionKey(String session_key) {
		return mapper.checkMemberWithSessionKey(session_key);
	}
	
	@Override
	public boolean keepLogin(String uuid, String session_key, Date session_limit) {
		boolean flag = false;
		
		int cnt = mapper.keepLogin(uuid, session_key, session_limit);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}

	@Override
	public MemberDTO getConnectedAccount(String uuid) {
		return mapper.getConnectedAccount(uuid);
	}

	@Override
	public void lastLoginUpdate(String uuid) {
		mapper.lastLoginUpdate(uuid);
	}

	@Override
	public boolean passwdCheck(String passwd, String passwdCheck) {
		return passwordEncoder.matches(passwd, passwdCheck);
	}
	
	@Override
	public boolean updateProfile(MemberDTO dto) {
		boolean flag = false;
		
		int cnt = mapper.updateProfile(dto);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}

	@Override
	public boolean updatePhoto(String uuid, String photo) {
		boolean flag = false;
		
		int cnt = mapper.updatePhoto(uuid, photo);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}

	@Override
	public MemberDTO getMemberByEmail(String email) {
		return mapper.getMemberByEmail(email);
	}
	
	@Override
	public MemberDTO getMemberByUuid(String uuid) {
		return mapper.getMemberByUuid(uuid);
	}
	
	@Override
	public boolean validCode(String uuid) {
		boolean flag = false;
		
		int cnt = mapper.validCode(uuid);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}

	@Transactional
	@Override
	public boolean resigerConnect(String uuid, String code) {
		boolean flag = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("uuid", uuid);
		map.put("code", code);
		
		int cnt = mapper.updateMemberConnectCode(map);
		if(cnt > 0) {
			cnt = mapper.updateMemberCode(map);
			if(cnt > 0) {
				flag = true;
			}
		}
		
		return flag;
	}

	@Override
	public MemberConnectDTO getCode(String code) {
		return mapper.getCode(code);
	}
	
	@Override
	public int sendMail(String email,
			String title, String message, String location, String btnStr) {
		int result = 0;
		MailHandler sendMail;
		try {
			sendMail = new MailHandler(mailSender);
			sendMail.setSubject(title);
			StringBuffer string = new StringBuffer();
			
			string.append("<div style='width:100%; padding:5%; box-sizing: border-box;'>");
			string.append("<div style='text-align:center; background-color: #efefef; border-radius:4px'>");
			string.append("<div style='font-weight:bold; font-size:1.8rem; color:#999;'>HEART SIGNAL</div>");
			string.append("<div style='position:relative; box-shadow: 0px 1px 5px rgba(0,0,0,0.1); background-color:#fff; top:5px; padding:5%;'>");
			string.append("<h2>안녕하세요 하트시그널입니다.</h2><br/>");
			string.append(message);
			string.append("<br/><br/><a style='text-decoration:none; background-color: #18A0FB; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 8px; border:none; color:#fff; font-weight:bold; padding:1rem; cursor:pointer;' href='");
			string.append("http://localhost:8080/hs");
			string.append(location);
			string.append("'>"+ btnStr +"</a><br/><br/>");
			string.append("</div></div></div>");
			
			sendMail.setText(string.toString());
			sendMail.setFrom("heartsignal55", "하트시그널");
			sendMail.setTo(email);
			sendMail.send();
			
			System.out.println("인증메일을 전송하였습니다");
			result = 1;
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {}
		
		return result;
	}
	
	@Transactional
	@Override
	public boolean createMember(Map<String, String> map) {
		boolean flag = false;
		
		
		int cnt = mapper.createMemberConnect(map);
		if(cnt > 0) {
			cnt = mapper.createMember(map);
			if(cnt > 0) {
				flag = true;
			}
		}
		
		return flag;
	}
	
	@Override
	public Map<String, String> registerMember(String email, String passwd) {
		boolean flag = false;
		
		List<String> list = mapper.getAllcode();
		String code = Utility.randomKey(list, 8);
		String uuid = Utility.getUuid();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("passwd", passwordEncoder.encode(passwd));
		map.put("code", code);
		map.put("uuid", uuid);
		
		flag = createMember(map);
		if(flag == true) {
			map.remove("passwd");
			return map;
		}else {
			return null;
		}
	}

	@Override
	public boolean duplicateEmail(String email) {
		boolean flag = false;
		
		int cnt = mapper.duplicateEmail(email);
		if(cnt > 0) {
			flag = true;
		}
		
		return flag;
	}
	
}
