package com.spring.hs;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.hs.dto.MemberDTO;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter {
	
	

	public AutoLoginInterceptor() {
		System.out.println("==============  인터셉터실행[AutoLogin] ======================");
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("member") != null) {
			System.out.println((MemberDTO)session.getAttribute("member"));
			response.sendRedirect(request.getContextPath() + "/main");
			return false;
		}
		
		return true;
		
	}

}
