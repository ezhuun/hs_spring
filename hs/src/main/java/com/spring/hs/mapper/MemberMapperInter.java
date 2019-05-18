package com.spring.hs.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.spring.hs.model.member.MemberConnectDTO;
import com.spring.hs.model.member.MemberDTO;

public interface MemberMapperInter {
	int deleteMember(String uuid);
	int deleteCode(String code);
	int clearCcode(String uuid);
	int deleteMemberConnectU2(String code);
	int changeMemberConnectUUID(String code);
	int tempCodeChange(String uuid);
	int disabledCode(String temp_code);
	int disconnectMember(Map<String, String> _map);
	int disconnectMemberConnect(Map<String, Object> map);
	int changePasswd(Map<String, String> map);
	String getCcodebyUuid(String uuid);
	MemberDTO checkMemberWithSessionKey(String session_key);
	int keepLogin(String uuid, String session_key, Date session_limit);
	MemberDTO getConnectedAccount(String uuid);
	int lastLoginUpdate(String uuid);
	int updateProfile(MemberDTO dto);
	int updatePhoto(String uuid, String photo);
	MemberDTO getMemberByUuid(String uuid);
	MemberDTO getMemberByEmail(String email);
	int validCode(String uuid);
	int updateMemberCode(Map<String, String> map);
	int updateMemberConnectCode(Map<String, String> map);
	MemberConnectDTO getCode(String code);
	int createMember(Map<String, String> map);
	int createMemberConnect(Map<String, String> map);
	int duplicateEmail(String email);
	List<String> getAllcode();
}
