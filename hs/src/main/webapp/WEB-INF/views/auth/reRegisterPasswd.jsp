<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display=none;"></div>
		<div class="auth-box">
			<form id="frm" name="frm" onsubmit="return false">
			<input type="hidden" id="uuid" name="uuid" value="${uuid}"/>
			<div class="auth-title">비밀번호 변경</div>
			<div class="auth-form">
				<div class="auth-inner-input nomargin">
					비밀번호 <input type="password" id="passwd" name="passwd" required/>
				</div>
			</div>
			<div class="auth-form">
				<div class="auth-inner-input nomargin">
					비밀번호 확인 <input type="password" id="passwdCheck" name="passwdCheck" required/>
				</div>
			</div> 
			<div class="auth-button">
				<button class="disabled" disabled id="submitBtn" onclick="handleChangePasswd();">
                  	<div class="loadingDot hidden">
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  	</div>
					<span class="submitStr">변경하기</span>
				</button>
			</div>
			</form>
		</div>
	</div>
</div>

<script src="${root}/js/utils.js" charset="utf-8"></script>
<script src="${root}/js/auth.js" charset="utf-8"></script>