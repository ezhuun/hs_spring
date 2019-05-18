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
	        				<img id="profileImage" src="<c:if test='${not empty profile}'>${root}/upload/profile/${profile}</c:if>" onError="this.src='${root}/upload/profile/default.png'">
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
		beegin_date.addEventListener('click', function() {
		  picker.open();
		}, false);

		const birth = document.querySelector("#birth");
		birth.addEventListener('click', function() {
		  picker2.open();
		}, false);

		const picker= new MaterialDatetimePicker({
			el: beegin_date,
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
