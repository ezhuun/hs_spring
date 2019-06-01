<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

	<div class="container-inner sideBorder boxsing">
		<c:if test="${member.lev == 1}"><h3>관리자입니다</h3><br/></c:if>
		
		<h4>나의정보</h4>
		[UUID]: ${member.uuid}<br>
		[EMAIL]: ${member.email}<br>
		[NAME]: ${member.name}<br>
		[C_CODE]: ${member.c_code}<br><br>
		
		<h4>상대방정보</h4>
		[UUID]: ${member.lover.uuid}<br>
		[EMAIL]: ${member.lover.email}<br>
		[NAME]: ${member.lover.name}<br>
		[C_CODE]: ${member.lover.c_code}<br><br>
		
		<h4>연결정보</h4>
		[C_CODE]: ${member.connect.c_code}<br>
		[U1]: ${member.connect.u1}<br>
		[U2]: ${member.connect.u2}<br>
		[d_status]: ${member.connect.d_status}<br>
		[d_limit]: ${member.connect.d_limit}<br>
		[d_uuid]: ${member.connect.d_uuid}<br><br>
		
		<button onclick="location.href='${pageContext.request.contextPath}/logout';">로그아웃</button>
		<button onclick="handleDisconnect('${member.uuid}');">연결끊기</button>
		<button onclick="handleDeleteMember('${member.uuid}');">회원탈퇴</button>
		<br><br>${member}
	</div>
	
	
	<script src="${pageContext.request.contextPath}/js/utils.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/js/common.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/js/auth.js" charset="utf-8"></script>