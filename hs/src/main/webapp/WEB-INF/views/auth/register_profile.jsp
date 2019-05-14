<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area nomargintop">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display=none;"></div>
		<div class="auth-box">
			<div class="auth-title">
				<div class="register-step">
					<div class="step active">1</div>
					<div class="step active">2</div>
					<div class="step active">3</div>
				</div>
				<span>연결성공! <br/>프로필을 입력해주세요</span>
			</div>
			<form id="frm" name="frm" method="post" onsubmit="return false">
			<input type="hidden" id="uuid" name="uuid" value="${uuid}"/>
			<div class="auth-form">
				<div class="auth-inner-input center nomargin">
	        		<div class="user_profile_circle">
	        				<img id="profileImage" src="<c:if test='${not empty profile}'>${root}/upload/profile/${profile}</c:if>" width="80" onError="this.src='${root}/upload/profile/default.png'">
	        			<label for="upload">
	        				<input type="file" accept="image/*" id="upload" name="upload" onchange="handleChangePhoto(event);">
	        			</label>
	        		</div>
					<div class="block">
						<label class="radio">여자
							<input type="radio" name="gender" value="w" checked required>
							<span class="checkmark"></span>
						</label>
						<label class="radio">남자
							<input type="radio" name="gender"value="m" required>
							<span class="checkmark"></span>
						</label>
					 </div>
				</div>
				<div class="auth-inner-input nomargin">
					이름 <input type="text" id="name" name="name" required/>
				</div>
				<div class="auth-inner-input nomargin">
					생일 <input type="text" id="birth" name="birth" readonly required/>
				</div>
				<div class="auth-inner-input">
					처음 만난 날 <input type="text" id="begin_date" name="begin_date" readonly required/>
				</div>
			</div> 
			<div class="auth-button">
				<button class="disabled" disabled id="submitBtn" onclick="handleClickUpdateProfile();">
                  	<div class="loadingDot hidden">
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  		<div></div>
                  	</div>
					<span class="submitStr">시작하기</span>
				</button>
			</div>
			</form>
		</div>
	</div>
</div>

<script src="${root}/js/utils.js" charset="utf-8"></script>
<script src="${root}/js/auth.js" charset="utf-8"></script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function(){
		const beegin_date = document.querySelector("#begin_date");
		begin_date.addEventListener('click', function() {
		  picker.open();
		}, false);

		const birth = document.querySelector("#birth");
		birth.addEventListener('click', function() {
		  picker2.open();
		}, false);

		const picker= new MaterialDatetimePicker({
			el: begin_date,
			format: 'YYYY-MM-DD',
			openedBy: 'focus'
		});
		const picker2= new MaterialDatetimePicker({
			el: birth,
			format: 'YYYY-MM-DD',
			openedBy: 'focus'
		});
	});
</script>

<script>
	const handleClickUpdateProfile = function(){
		initHelp();
		const name = document.querySelector("#name").value.trim();
		if(name.length < 2){
			createHelp(1, " - 최소 2자리 이상 입력해주세요");
			return;
		}
		if(new RegExp('[`~!@#$%^&*|\\\'\";:\/?]','gi').test(name) == true){
			createHelp(1, " - 특수문자는 포함할 수 없습니다");
			return;
		}
		
		const param = $("#frm").serialize();
	    const loadingDot = document.querySelector(".loadingDot");
	    const submitStr = document.querySelector(".submitStr");
	    $.ajax({
	        url: contextPath + "/updateProfile",
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
	        	if(data != "0"){
	        		location.href = contextPath + "/main";
	        	}else{
	        		utils.alert('로그인에 실패했습니다');
	        	}
	        }
	    });
	}

	const handleChangePhoto = function(e){
		let file = e.target.files[0];
		let formData = new FormData();
		formData.append("file", file);
		formData.append("uuid", document.querySelector("#uuid").value.trim());
		
		$.ajax({
			url: contextPath + "/upload/uploadAjax",
			method: "post",
			type: "json",
			data: formData,
			processData: false,
			contentType: false,
			success: function (data) {
				if(data != "0"){
					document.querySelector("#profileImage").src=contextPath + "/upload/profile/" + data;
				}else{
					utils.alert('이미지 등록 실패');
				}
			}
		});
	}
</script>


