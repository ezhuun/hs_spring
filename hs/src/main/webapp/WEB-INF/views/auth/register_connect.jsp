<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display:none;"></div>
		<div class="auth-box">
			<div class="auth-title">
				<div class="register-step">
					<div class="step active">1</div>
					<div class="step active">2</div>
					<div class="step">3</div>
				</div>
				<span>서로의 초대코드를 입력하여 연결해 주세요</span>
			</div>
			<div class="auth-form">
				<div class="auth-inner-input textSmall">
					<span class="block">내 초대코드</span> <input type="text" id="mycode" name="mycode" value="${ fn:substring(code, 0, 4) } ${ fn:substring(code, 4, 8) }" class="input_inline" readonly/>
					<button onclick="handleClickOpenSendBox();">공유</button>
				</div>
				<div class="auth-inner-input textSmall">
					상대방 초대코드를 전달받으셨나요? 
					<input type="text" id="code" name="code" placeholder="전달받은 초대코드 입력" onKeyup="isNumber(this);"/>
					<input type="hidden" id="uuid" name="uuid" value="${uuid}" />
				</div>
			</div> 
			<div class="auth-button">
				<button class="disabled" disabled id="submitBtn" onclick="handleClickConnect();">
                  	<div class="loadingDot hidden">
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  	</div>
					<span class="submitStr">연결하기</span>
				</button>
			</div>
		</div>
	</div>
</div>

<script src="${root}/js/utils.js" charset="utf-8"></script>
<script src="${root}/js/auth.js" charset="utf-8"></script>
<script>
	const handleClickConnect = function(){
		initHelp();
		const uuid = document.querySelector("#uuid").value.trim();
		const code = document.querySelector("#code").value.trim();
		
		if(code.length !== 8){
			createHelp(1, " - 유효한 코드가 아닙니다");
			return;
		}
		
		const param = {uuid: uuid, code: code};
	    const loadingDot = document.querySelector(".loadingDot");
	    const submitStr = document.querySelector(".submitStr");
	    $.ajax({
	        url: contextPath + "/registerCode",
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
	        		//code is null
	        		createHelp(1, " - 유효한 코드가 아닙니다");
	        	}else if(data.result == "2"){
	        		//자신의 코드로는 등록할 수 없습니다
	        		createHelp(1, " - 유효한 코드가 아닙니다");
	        	}else if(data.result == "3"){
	        		//초대코드 만료(이미 연결된 사용자인지, 등록안료된 초대코드인지)
	        		createHelp(1, " - 유효한 코드가 아닙니다");
	        	}else if(data.result == "4"){
	        		//db error
	        		utils.alert('DB error');
	        	}else if(data.result == "1"){
	        		//연결성공
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
		
	};
	
	const sendEmail = function(mycode){
		const email = document.querySelector("#sendEmail").value.trim();
		if(email == ""){
			utils.alert('이메일 주소를 입력해주세요');
			return;
		}
		
		const title = "[HEART SIGNAL] 상대방에게서 초대코드가 도착했습니다";
		const message = "상대방과 연결을 위해<br/>하트시그널 가입 후<br/>아래 초대코드를 입력해주세요<h3>"+mycode+"</h3>";
		
		const param = {email: email, title: title, message: message};
		const url = contextPath + "/sendEmail";
		
		const modal = document.querySelector(".modal-form-container");
		const loadingDot = modal.querySelector(".loadingDot");
		const btnStr = modal.querySelector(".btnStr");

	    $.ajax({
	        url: url,
	        method: "post",
	        type: "json",
	        data: param,
	        beforeSend: function() {
	        	loadingDot.classList.remove("hidden");
	        	btnStr.classList.add("hidden");
	        },
	        complete: function() {
	        	loadingDot.classList.add("hidden");
	        	btnStr.classList.remove("hidden");
	        },
	        error: function(err) {
	            utils.alert('서버에러');
	            loadingDot.classList.add("hidden");
	            btnStr.classList.remove("hidden");
	        },
	        success: function(data) {
	        	if(data == "1") {
	        		utils.alert('메일을 전송했습니다');
	        		utils.popupFormClose();
	        	}else{
	        		utils.alert('메일전송에 실패했습니다. 다시 시도해주세요');
	        	}
	        }
	    });
	};
	
	const handleClickOpenSendBox = function(){
		const mycode = document.querySelector("#mycode").value;
		utils.popupForm("초대코드 공유",
				"<span>아래 이메일주소로 초대코드를 전송합니다</span> <input type='email' id='sendEmail'/> ",
				"<button onclick='sendEmail(\""+mycode+"\");'><div class='loadingDot hidden'><div></div><div></div><div></div></div><span class='btnStr'>전송</span></button>"
				);
	};
</script>