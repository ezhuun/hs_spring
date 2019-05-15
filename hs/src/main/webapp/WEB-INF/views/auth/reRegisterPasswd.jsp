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
<script>

	const handleChangePasswd = function(){
		initHelp();
		
		const passwd = document.querySelector("#passwd").value;
		const passwdCheck = document.querySelector("#passwdCheck").value;

		let valid = ![passwd, passwdCheck].includes("");
	    if (valid == false) {
	        return;
	    }
	    if (passwd.length < 4) {
	        valid = false;
	        createHelp(0, " - 최소 4자리 이상 입력해주세요");
	        return;
	    }
	    
	    if(passwd !== passwdCheck){
	    	valid = false;
	    	createHelp(0, " - 비밀번호가 일치하지 않습니다");
	    	return;
	    }
	    
	    const param = $("#frm").serialize();
	    const loadingDot = document.querySelector(".loadingDot");
	    const submitStr = document.querySelector(".submitStr");
	    
	    $.ajax({
	        url: contextPath + "/reRegisterPasswd",
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
	            utils.alert('서버통신오류');
	            loadingDot.classList.add("hidden");
	            submitStr.classList.remove("hidden");
	        },
	        success: function(data) {
	        	if(data == "1"){
	        		utils.alert('비밀번호가 변경되었습니다', contextPath+'/');
	        	}else{
	        		utils.alert('비밀번호 변경을 실패했습니다');
	        	}
	        }
	    });
	}
</script>