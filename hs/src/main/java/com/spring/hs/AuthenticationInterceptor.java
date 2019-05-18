package com.spring.hs;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.hs.dto.member.MemberDTO;
import com.spring.hs.service.member.MemberService;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	MemberService service;

	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("member");
		if ( obj == null ){
			Cookie cookieLogin = WebUtils.getCookie(request, "cookieLogin");
			if(cookieLogin != null) {
				String session_key = cookieLogin.getValue();
				MemberDTO dto = service.checkMemberWithSessionKey(session_key);

				if(dto != null) {
					dto.setLover(service.getConnectedAccount(dto.getUuid()));
					dto.setConnect(service.getCode(dto.getC_code()));
					session.setAttribute("member", dto);
					
					return true;
				}
			}
			
			// 아래는 로그인도 안되있고 쿠키도 존재하지 않는 경우니까 다시 로그인 폼으로 돌려보내면 된다.
			// 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
			response.sendRedirect(request.getContextPath()+"/login");
			return false;
		}else {
			MemberDTO _dto = (MemberDTO)obj;
			MemberDTO dto = service.getMemberByUuid(_dto.getUuid());
			dto.setLover(service.getConnectedAccount(dto.getUuid()));
			dto.setConnect(service.getCode(dto.getC_code()));
			try {
				session.setAttribute("member", dto);
			} catch (Exception e) {}
		}
		
		
		return true;
	}
	
	// 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
	
	
	
}
