package com.spring.hs.dao.member;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.hs.dto.member.MemberConnectDTO;
import com.spring.hs.dto.member.MemberDTO;

public interface MemberDAO {
	
	
	boolean deleteMember(String uuid);
	boolean deleteCode(String code);
	boolean clearCcode(String uuid);
	boolean deleteMemberConnectU2(String code);
	boolean changeMemberConnectUUID(String code);
	boolean tempCodeChange(String uuid);
	boolean disabledCode(String temp_code);
	boolean disconnectMember(Map<String, String> _map);
	boolean disconnectMemberConnect(Map<String, Object> map);
	boolean changePasswd(Map<String, String> map);
	String getCcodebyUuid(String uuid);
	MemberDTO checkMemberWithSessionKey(String session_key);
	boolean keepLogin(String uuid, String session_key, Date session_limit);
	MemberDTO getConnectedAccount(String uuid);
	void lastLoginUpdate(String uuid);
	boolean updateProfile(MemberDTO dto);
	boolean updatePhoto(String uuid, String photo);
	MemberDTO getMemberByUuid(String uuid);
	MemberDTO getMemberByEmail(String email);
	boolean validCode(String uuid);
	boolean updateMemberCode(Map<String, String> map);
	boolean updateMemberConnectCode(Map<String, String> map);
	MemberConnectDTO getCode(String code);
	boolean createMember(Map<String, String> map);
	boolean createMemberConnect(Map<String, String> map);
	boolean duplicateEmail(String email);
	List<String> getAllcode();
	
	
	
	
	
	
	
	
	
}
