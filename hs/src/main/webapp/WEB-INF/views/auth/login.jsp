<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display=none;"></div>
		<div class="auth-box">
			<form id="frm" name="frm" onsubmit="return false">
			<div class="auth-title">로그인</div>
			<div class="auth-form">
				<div class="auth-inner-input">
					이메일 <input type="email" id="email" name="email" required/>
					<label for="isLogin">
						<input type="checkbox" tabindex="-1" id="isLogin" name="isLogin" value="y" onchange="rememberMe(this);"/>
						<span class="textSmall" style="color:#666 !important;">로그인을 기억할게요</span>
					</label>
				</div>
				<div class="auth-inner-input">
					비밀번호 <input type="password" id="passwd" name="passwd" required/>
					<span class="link textSmall" onclick="handleClickForgetPasswd();">비밀번호를 잊어버리셨습니까?</span>
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

	const handleClickForgetPasswd = function(){
		initHelp();
		const email = document.querySelector("#email").value;
		if(email == ""){
			createHelp(0, " - 입력바랍니다");
			return;
		}
	    let regex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	    if (regex.test(email) == false) {
	        valid = false;
	        createHelp(0, " - 형식이 올바르지 않습니다");
	        return;
	    }
	    utils.alert('<준비중><br>1. 이메일 유효성 체크 <br>2.비밀번호 변경 URL 메일보내기<br>3.비밀번호변경페이지작성');
	}

	const handleClickLogin = function(){
		initHelp();
		const email = document.querySelector("#email").value;
		const passwd = document.querySelector("#passwd").value;
		
		let valid = ![email, passwd].includes("");
	    if (valid == false) {
	        return;
	    }
	    let regex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	    if (regex.test(email) == false) {
	        valid = false;
	        createHelp(0, " - 형식이 올바르지 않습니다");
	        return;
	    }
	    if (passwd.length < 4) {
	        valid = false;
	        createHelp(1, " - 최소 4자리 이상 입력해주세요");
	        return;
	    }
	    
	    const param = $("#frm").serialize();
	    const loadingDot = document.querySelector(".loadingDot");
	    const submitStr = document.querySelector(".submitStr");
	    $.ajax({
	        url: contextPath + "/loginProc",
	        method: "post",
	        type: "json",
	        data: param,
	        beforeSend: function() {
	        	loadingDot.classList.remove("hidden");
	            submitStr.classList.add("hidden");
	        },
	        complete: function() {
	        	loadingDot.classList.add("hidden");
	            submitStr.classList.remove("hidden");
	        },
	        error: function(err) {
	            utils.alert('서버에러');
	            loadingDot.classList.add("hidden");
	            submitStr.classList.remove("hidden");
	        },
	        success: function(data) {
	        	if(data.result == "0"){
	        		//회원정보없음
	        		createHelp(0, " - 회원정보가 존재하지 않습니다");
	        	}else if(data.result == "1"){
	        		//로그인성공
	        		location.href = contextPath + "/main";
	        	}else if(data.result == "2"){
	        		//비밀번호 불일치
	        		createHelp(1, " - 비밀번호가 일치하지 않습니다");
	        	}else if(data.result == "3"){
	        		//계정연결페이지이동
	        		let form = document.createElement("form");
	                form.setAttribute("charset", "UTF-8");
	                form.setAttribute("method", "post");
	                form.setAttribute("action", contextPath+"/connect");
	                
	                let hiddenField = document.createElement("input");
	                hiddenField.setAttribute("type", "hidden");
	                hiddenField.setAttribute("name", "uuid");
	                hiddenField.setAttribute("value", data.uuid);
	                form.appendChild(hiddenField);
	                
	                hiddenField = document.createElement("input");
	                hiddenField.setAttribute("type", "hidden");
	                hiddenField.setAttribute("name", "code");
	                hiddenField.setAttribute("value", data.code);
	                form.appendChild(hiddenField);
	                
	                document.body.appendChild(form);
	                form.submit();
	        	}else if(data.result == "4"){
	        		//프로필입력페이지 이동
	        		let form = document.createElement("form");
	        		form.setAttribute("style", "display:none");
	                form.setAttribute("charset", "UTF-8");
	                form.setAttribute("method", "post");
	                form.setAttribute("action", contextPath+"/profile");
	                
	                let hiddenField = document.createElement("input");
	                hiddenField.setAttribute("type", "hidden");
	                hiddenField.setAttribute("name", "uuid");
	                hiddenField.setAttribute("value", data.uuid);
	                form.appendChild(hiddenField);
	                
	                document.body.appendChild(form);
	                form.submit();
	        	}
	        }
	    });
	}

	const rememberMe = function(radio) {
	    if (radio.checked === true) {
	        utils.alert('우리는 최소 3일간 당신을 기억하겠습니다');
	    }
	}
</script>