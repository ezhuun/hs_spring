package com.spring.hs.service;

import java.io.UnsupportedEncodingException;
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
import com.spring.hs.dao.MemberDAO;
import com.spring.hs.dto.MemberConnectDTO;
import com.spring.hs.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDAO dao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender mailSender;
	
	
	
	
	@Override
	public boolean updateProfile(MemberDTO dto) {
		return dao.updateProfile(dto);
	}

	@Override
	public boolean updatePhoto(String uuid, String photo) {
		return dao.updatePhoto(uuid, photo);
	}

	@Override
	public MemberDTO getMemberByEmail(String email) {
		return dao.getMemberByEmail(email);
	}
	
	@Override
	public MemberDTO getMemberByUuid(String uuid) {
		return dao.getMemberByUuid(uuid);
	}
	
	@Override
	public boolean validCode(String uuid) {
		return dao.validCode(uuid);
	}

	@Transactional
	@Override
	public boolean resigerConnect(String uuid, String code) {
		boolean flag = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("uuid", uuid);
		map.put("code", code);
		
		flag = dao.updateMemberConnectCode(map);
		flag = dao.updateMemberCode(map);
		
		return flag;
	}

	@Override
	public MemberConnectDTO getCode(String code) {
		return dao.getCode(code);
	}
	
	@Override
	public int sendMail(String email, String title, String message, String location) {
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
			string.append("<h2>안녕하세요</h2><br/>");
			string.append(message);
			string.append("<br/><br/><a style='text-decoration:none; background-color: #18A0FB; box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25); border-radius: 8px; border:none; color:#fff; font-weight:bold; padding:1rem; cursor:pointer;' href='");
			string.append("http://localhost:8080/hs");
			string.append(location);
			string.append("'>Click</a><br/><br/>");
			string.append("</div></div></div>");
			
			sendMail.setText(string.toString());
			sendMail.setFrom("heartsignal55", "HEARTSIGNAL");
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
		
		flag = dao.createMemberConnect(map);
		flag = dao.createMember(map);
		
		return flag;
	}
	
	@Override
	public Map<String, String> registerMember(String email, String passwd) {
		boolean flag = false;
		
		List<String> list = dao.getAllcode();
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
		return dao.duplicateEmail(email);
	}
	
	
}
