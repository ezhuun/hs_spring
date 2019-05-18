<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display=none;"></div>
		<div class="auth-box">
			<div class="auth-title">
				<div class="register-step">
					<div class="step active">1</div>
					<div class="step">2</div>
					<div class="step">3</div>
				</div>
				<span>새로운 계정을 생성합니다</span>
			</div>
			<form id="frm" method="post" onsubmit="return false">
			<div class="auth-form">
				<div class="auth-inner-input nomargin">
					이메일 <input type="email" id="email" name="email" required/>
				</div>
				<div class="auth-inner-input nomargin">
					비밀번호 <input type="password" id="passwd" name="passwd" required/>
				</div>
				<div class="auth-inner-input nomargin">
					비밀번호 확인 <input type="password" id="passwdCheck" name="passwdCheck" required/>
				</div>
			</div>
			<div class="auth-button">
				<button class="disabled" disabled id="submitBtn" onclick="handleClickRegister();">
                  	<div class="loadingDot hidden">
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  	</div>
					<span class="submitStr">가입하기</span>
				</button>
			</div>
			</form>
			<div class="auth-etc textSmall">
				<span class="link" onclick="location.href='login';">이미 계정이 있으신가요?</span>
			</div>
		</div>
	</div>
</div>
	

<script src="${root}/js/utils.js" charset="utf-8"></script>
<script src="${root}/js/auth.js" charset="utf-8"></script>