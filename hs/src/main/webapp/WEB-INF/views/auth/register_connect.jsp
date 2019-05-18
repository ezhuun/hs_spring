<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>

<div class="wrap-auth">
	<div class="box-area">
		<div class="logo"><img src="${root}/images/logo.png" onerror="this.display=none;"></div>
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