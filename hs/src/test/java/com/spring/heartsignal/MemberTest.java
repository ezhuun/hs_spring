package com.spring.heartsignal;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.hs.Utility;
import com.spring.hs.mapper.MemberMapperInter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MemberTest {
	
	//private static final Logger logger = LoggerFactory.getLogger(MemberTest.class);

	@Autowired
	MemberMapperInter mapper;
	

	//@Test
	public void updateMemberCode() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("uuid", "77b4ca96257645d6887130c6ba0c8d5e");
		map.put("code", "03585327");
		mapper.updateMemberCode(map);
	}
	
	//@Test
	public void updateMemberConnectCode() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("uuid", "77b4ca96257645d6887130c6ba0c8d5e");
		map.put("code", "03585327");
		mapper.updateMemberConnectCode(map);
	}
	
	//@Test
	public void getAllCode() {
		List<String> list = mapper.getAllcode();
		
		if(list != null) {
			for(int i=0; i<list.size(); i++) {
				System.out.println(list.get(i));
			}
		}else {
			System.out.println("code is null");
		}
		
		String key = Utility.randomKey(list, 8);
		System.out.println("key: " + key);
	} 
	
	@Test
	public void randomKey() {
		List<String> list = new ArrayList<String>();
		list.add("12345678");
		list.add("87654321");
		
		String key = Utility.randomKey(list, 8);
		
		System.out.println(key);
	}
}
