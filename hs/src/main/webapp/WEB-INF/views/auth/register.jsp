<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display:none;"></div>
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
					비밀번호 확인 <input type="password" id="passwdcheck" name="passwdcheck" required/>
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
<script>
	const handleClickRegister = function(){
		initHelp();
		const email = document.querySelector("#email").value;
		const passwd = document.querySelector("#passwd").value;
		const passwdcheck = document.querySelector("#passwdcheck").value;

		let valid = ![email, passwd, passwdcheck].includes("");
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
	    
	    if(passwd !== passwdcheck){
	    	valid = false;
	    	createHelp(1, " - 비밀번호가 일치하지 않습니다");
	    	return;
	    }
	    
	    const param = $("#frm").serialize();
	    const loadingDot = document.querySelector(".loadingDot");
	    const submitStr = document.querySelector(".submitStr");
	    $.ajax({
	        url: contextPath + "/register",
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
	        		createHelp(0, " - 중복된 이메일입니다");
	        	}else if(data.result == "2"){
	        		utils.alert('다시 시도 해주세요');
	        	}else if(data.result == "1"){
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
	        	}
	        }
	    });
	}
</script>

