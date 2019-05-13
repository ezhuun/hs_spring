<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display:none;"></div>
		<div class="auth-box">
			<form id="frm" name="frm" onsubmit="return false">
			<div class="auth-title">로그인</div>
			<div class="auth-form">
				<div class="auth-inner-input">
					이메일 <input type="email" id="email" name="email" required/>
					<label for="isLogin">
						<input type="checkbox" tabindex="-1" id="isLogin" name="isLogin" value="y" onchange="rememberMe(this);"/>
						<span class="textSmall">로그인을 기억할게요</span>
					</label>
				</div>
				<div class="auth-inner-input">
					비밀번호 <input type="password" id="passwd" name="passwd" required/>
					<span class="link textSmall" onclick="utils.alert('준비중');">비밀번호를 잊어버리셨습니까?</span>
				</div>
			</div> 
			<div class="auth-button">
				<button class="disabled" disabled id="submitBtn" onclick="handleClickLogin();">
                  	<div class="loadingDot hidden">
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  	</div>
					<span class="submitStr">로그인</span>
				</button>
			</div>
			</form>
			<div class="auth-etc textSmall">
				계정이 없으신가요?<span class="link" onclick="location.href='register'"> 가입하기</span>
			</div>
		</div>
	</div>
</div>

<script src="${root}/js/utils.js" charset="utf-8"></script>
<script src="${root}/js/auth.js" charset="utf-8"></script>
<script>

	const handleClickLogin = function(){
		utils.alert('준비중');
	}

	const rememberMe = function(radio) {
	    if (radio.checked === true) {
	        utils.alert('우리는 최소 3일간 당신을 기억하겠습니다');
	    }
	}
</script>