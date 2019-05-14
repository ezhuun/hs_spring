package com.spring.hs.service;

import java.util.Date;
import java.util.Map;

import com.spring.hs.dto.MemberConnectDTO;
import com.spring.hs.dto.MemberDTO;

public interface MemberService {
	
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
	public int sendMail(String email, String title, String message, String location);
	public boolean createMember(Map<String, String> map);
	public Map<String, String> registerMember(String email, String passwd);
	public boolean duplicateEmail(String email);
	
	
}
