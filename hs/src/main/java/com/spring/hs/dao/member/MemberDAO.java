package com.spring.hs.dao.member;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.hs.dto.member.MemberConnectDTO;
import com.spring.hs.dto.member.MemberDTO;

public interface MemberDAO {
	
	public boolean changePasswd(Map<String, String> map);
	public String getCcodebyUuid(String uuid);
	public MemberDTO checkMemberWithSessionKey(String session_key);
	public boolean keepLogin(String uuid, String session_key, Date session_limit);
	public MemberDTO getConnectedAccount(String uuid);
	public void lastLoginUpdate(String uuid);
	public boolean updateProfile(MemberDTO dto);
	public boolean updatePhoto(String uuid, String photo);
	public MemberDTO getMemberByUuid(String uuid);
	public MemberDTO getMemberByEmail(String email);
	public boolean validCode(String uuid);
	public boolean updateMemberCode(Map<String, String> map);
	public boolean updateMemberConnectCode(Map<String, String> map);
	public MemberConnectDTO getCode(String code);
	public boolean createMember(Map<String, String> map);
	public boolean createMemberConnect(Map<String, String> map);
	public boolean duplicateEmail(String email);
	public List<String> getAllcode();
	
	
	
}
