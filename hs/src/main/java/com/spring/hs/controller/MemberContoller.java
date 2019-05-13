package com.spring.hs.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.hs.Utility;
import com.spring.hs.dto.MemberConnectDTO;
import com.spring.hs.dto.MemberDTO;
import com.spring.hs.service.MemberService;

@Controller
public class MemberContoller {

	private static final Logger logger = LoggerFactory.getLogger(MemberContoller.class);
	
	@Autowired
	MemberService service;
	
	@ResponseBody
	@PostMapping("/updateProfile")
	public String updateProfile(MemberDTO dto) {
		String result = "0";
		
		if(service.updateProfile(dto)) {
			result = "1";
			
			
			//session member객체 저장해야함.
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/upload/uploadAjax", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public String uploadAjax(HttpServletRequest request,
			MultipartFile file, 
			@RequestParam String uuid) throws Exception{
		String result = "0";
		
		String basePath = request.getRealPath("/resources/upload/profile");
		if(file.getContentType().indexOf("image") >= 0) {
			String fileName = Utility.saveFileSpring(file, basePath);
			
			if(fileName != null) {
				MemberDTO dto = service.getMemberByUuid(uuid);
				if(service.updatePhoto(uuid, fileName)) {
					if(dto.getProfile() != null || dto.getProfile().equals("")) {
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
			if(dto.getU1().equals(uuid)) {
				map.put("result", "2");
				map.put("msg", "자신의 초대코드는 등록할 수 없습니다");
			}else {
				boolean validCode = service.validCode(dto.getU1());
				if(validCode == false && (dto.getU2() == null || dto.getU2().equals("")) ){
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
	public String sendEmail(String email, String title, String message) {
		int res = service.sendMail(email, title, message, "/register");
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
	
}
