package com.spring.hs.service.member;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
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
import com.spring.hs.dao.member.MemberDAO;
import com.spring.hs.dto.member.MemberConnectDTO;
import com.spring.hs.dto.member.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO dao;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender mailSender;
	

	@Override
	public boolean deleteMember(String uuid) {
		boolean flag = false;
		MemberDTO dto = getMemberByUuid(uuid);
		
		try {
			dao.deleteMember(dto.getUuid());
			dao.deleteCode(dto.getTemp_code());
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

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
				dao.disconnectMemberConnect(map);
		
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
						dao.changeMemberConnectUUID(dto.getC_code());
						//상대방의 기존 TEMP_CODE [MEMBER_CONNECT]는 삭제..
						dao.deleteCode(_dto.getTemp_code());
						//상대방의 [MEMBER] C_CODE -> TEMP_CODE로 변경
						dao.tempCodeChange(_dto.getUuid());
					}else {
						//상대방이 연결을 먼저끊었다면..
						//기존 code disabled
						dao.disabledCode(dto.getC_code());
					}

					//TEMP_CODE 다시 발급..
					List<String> list = dao.getAllcode();
					String c_code = Utility.randomKey(list, 8);
					
					Map<String, String> _map = new HashMap<String, String>();
					_map.put("uuid", dto.getUuid());
					_map.put("code", c_code);
					
					//[MEMBER_CONNECT] C_CODE 입력
					dao.createMemberConnect(_map);
					//[MEMBER] C_CODE 초기화, TEMP_CODE업데이트
					dao.disconnectMember(_map);
				}else {
					//같지 않다면
					//상대방 코드로 연결되어있는 상태
					
					//MEMBER_CONNECT U2는 나자신이기 때문에 삭제
					dao.deleteMemberConnectU2(dto.getC_code());
					//내 temp_code는 아직 사용하지 않았기 때문에
					//code를 다시 발급받을 필요가 없다. 기존C_CODE만 초기화
					dao.clearCcode(dto.getUuid());
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
		Map<String, String> map = new HashMap<String, String>();
		map.put("uuid", uuid);
		map.put("passwd", passwordEncoder.encode(passwd));
		
		return dao.changePasswd(map);
	}

	@Override
	public String getCcodebyUuid(String uuid) {
		return dao.getCcodebyUuid(uuid);
	}

	@Override
	public MemberDTO checkMemberWithSessionKey(String session_key) {
		return dao.checkMemberWithSessionKey(session_key);
	}
	
	@Override
	public boolean keepLogin(String uuid, String session_key, Date session_limit) {
		return dao.keepLogin(uuid, session_key, session_limit);
	}

	@Override
	public MemberDTO getConnectedAccount(String uuid) {
		return dao.getConnectedAccount(uuid);
	}

	@Override
	public void lastLoginUpdate(String uuid) {
		dao.lastLoginUpdate(uuid);
	}

	@Override
	public boolean passwdCheck(String passwd, String passwdCheck) {
		return passwordEncoder.matches(passwd, passwdCheck);
	}
	
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
		if(flag == true) {
			flag = dao.updateMemberCode(map);
		}
		
		return flag;
	}

	@Override
	public MemberConnectDTO getCode(String code) {
		return dao.getCode(code);
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
		
		flag = dao.createMemberConnect(map);
		if(flag == true) {
			flag = dao.createMember(map);
		}
		
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
