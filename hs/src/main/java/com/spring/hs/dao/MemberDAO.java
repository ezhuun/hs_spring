package com.spring.hs.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.spring.hs.dto.MemberConnectDTO;
import com.spring.hs.dto.MemberDTO;

public interface MemberDAO {
	
	
	
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
