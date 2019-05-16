package com.spring.hs.service.member;

import java.util.Date;
import java.util.Map;

import com.spring.hs.dto.member.MemberConnectDTO;
import com.spring.hs.dto.member.MemberDTO;

public interface MemberService {
	
	
	public boolean updateDisconnectStatus(String uuid, String code, Date limit);
	public boolean changePasswd(String uuid, String passwd);
	public String getCcodebyUuid(String uuid);
	public MemberDTO checkMemberWithSessionKey(String session_key);
	public boolean keepLogin(String uuid, String session_key, Date session_limit);
	public MemberDTO getConnectedAccount(String uuid);
	public void lastLoginUpdate(String uuid);
	public boolean passwdCheck(String passwd, String passwdCheck);
	public boolean updateProfile(MemberDTO dto);
	public boolean updatePhoto(String uuid, String photo);
	public MemberDTO getMemberByUuid(String uuid);
	public MemberDTO getMemberByEmail(String email);
	public boolean validCode(String uuid);
	public boolean resigerConnect(String uuid, String code);
	public MemberConnectDTO getCode(String code);
	public int sendMail(String email, String title, String message, String location, String btnStr);
	public boolean createMember(Map<String, String> map);
	public Map<String, String> registerMember(String email, String passwd);
	public boolean duplicateEmail(String email);
	
	
}
