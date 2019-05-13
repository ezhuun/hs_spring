package com.spring.hs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.hs.dto.MemberConnectDTO;
import com.spring.hs.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "MemberMapper";
	
	
	
	
	
	
	
	
	@Override
	public boolean updateProfile(MemberDTO dto) {
		boolean flag = false;
		
		int cnt = sqlSession.update(NAMESPACE+".updateProfile", dto);
		if(cnt > 0) {
			flag = true;
		}

		return flag;
	}



	@Override
	public boolean updatePhoto(String uuid, String photo) {
		boolean flag = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("uuid", uuid);
		map.put("photo", photo);
		
		int cnt = sqlSession.update(NAMESPACE+".updateProfile", map);
		
		if(cnt > 0) {
			flag = true;
		}
		return flag;
	}
	
	
	
	@Override
	public MemberDTO getMemberByEmail(String email) {
		return sqlSession.selectOne(NAMESPACE+".getMemberByEmail", email);
	}
	
	@Override
	public MemberDTO getMemberByUuid(String uuid) {
		return sqlSession.selectOne(NAMESPACE+".getMemberByUuid", uuid);
	}
	
	
	@Override
	public boolean validCode(String uuid) {
		boolean flag = false;
		
		int cnt = sqlSession.selectOne(NAMESPACE+".validCode", uuid);
		if(cnt > 0) {
			flag = true;
		}

		return flag;
	}

	@Override
	public boolean updateMemberCode(Map<String, String> map) {
		boolean flag = false;
		
		int cnt = sqlSession.update(NAMESPACE+".updateMemberCode", map);
		if(cnt > 0) {
			flag = true;
		}

		return flag;
	}

	@Override
	public boolean updateMemberConnectCode(Map<String, String> map) {
		boolean flag = false;
		
		
		System.out.println("======================================================");
		System.out.println(map.get("uuid"));
		System.out.println(map.get("code"));
		
		int cnt = sqlSession.update(NAMESPACE+".updateMemberConnectCode", map);
		if(cnt > 0) {
			flag = true;
		}

		return flag;
	}

	@Override
	public MemberConnectDTO getCode(String code) {
		return sqlSession.selectOne(NAMESPACE+".getCode", code);
	}
	
	@Override
	public boolean createMember(Map<String, String> map) {
		boolean flag = false;
		
		int cnt = sqlSession.insert(NAMESPACE+".createMember", map);
		if(cnt > 0) {
			flag = true;
		}

		return flag;
	}

	@Override
	public boolean createMemberConnect(Map<String, String> map) {
		boolean flag = false;
		int cnt = sqlSession.insert(NAMESPACE+".createMemberConnect", map);
		if(cnt > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean duplicateEmail(String email) {
		boolean flag = false;
		int cnt = sqlSession.selectOne(NAMESPACE+".duplicateEmail", email);
		if(cnt > 0) {
			flag = true;
		}
		return flag;
	}
	
	@Override
	public List<String> getAllcode() {
		return sqlSession.selectList(NAMESPACE+".getAllcode");
	}


	
	
	
	
}
