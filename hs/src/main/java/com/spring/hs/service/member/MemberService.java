package com.spring.hs.service.member;

import java.util.Date;
import java.util.Map;

import com.spring.hs.dto.member.MemberConnectDTO;
import com.spring.hs.dto.member.MemberDTO;

public interface MemberService {
	
	boolean deleteMember(String uuid);
	boolean updateDisconnectStatus(String uuid, Date limit);
	boolean changePasswd(String uuid, String passwd);
	String getCcodebyUuid(String uuid);
	MemberDTO checkMemberWithSessionKey(String session_key);
	boolean keepLogin(String uuid, String session_key, Date session_limit);
	MemberDTO getConnectedAccount(String uuid);
	void lastLoginUpdate(String uuid);
	boolean passwdCheck(String passwd, String passwdCheck);
	boolean updateProfile(MemberDTO dto);
	boolean updatePhoto(String uuid, String photo);
	MemberDTO getMemberByUuid(String uuid);
	MemberDTO getMemberByEmail(String email);
	boolean validCode(String uuid);
	boolean resigerConnect(String uuid, String code);
	MemberConnectDTO getCode(String code);
	int sendMail(String email, String title, String message, String location, String btnStr);
	boolean createMember(Map<String, String> map);
	Map<String, String> registerMember(String email, String passwd);
	boolean duplicateEmail(String email);
	
	
	
}
