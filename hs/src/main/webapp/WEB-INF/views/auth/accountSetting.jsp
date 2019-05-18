<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>하트시그널</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">
	<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/material-datetime-picker.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
	
	<script src="${pageContext.request.contextPath}/lib/jquery-3.4.1.min.js"></script>
	<script src="https://unpkg.com/babel-polyfill@6.2.0/dist/polyfill.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/rome/2.1.22/rome.standalone.js"></script>
	<script src="${pageContext.request.contextPath}/lib/material-datetime-picker.js" charset="utf-8"></script>

</head>
<body>
	<span id="contextPathHolder" data-contextPath="${pageContext.request.contextPath}" style="display:none;"></span>
	<span id="connectLimit" data-connectLimit="${member.connect.d_limit}" style="display:none;"></span>
	
	<c:if test="${member.lev == 1}"><h3>관리자입니다</h3><br/></c:if>
	
	<h4>나의정보</h4>
	[UUID]: ${member.uuid}<br>
	[EMAIL]: ${member.email}<br>
	[NAME]: ${member.name}<br>
	[C_CODE]: ${member.c_code}<br><br>
	
	<h4>상대방정보</h4>
	[UUID]: ${member.lover.uuid}<br>
	[EMAIL]: ${member.lover.email}<br>
	[NAME]: ${member.lover.name}<br>
	[C_CODE]: ${member.lover.c_code}<br><br>
	
	<h4>연결정보</h4>
	[C_CODE]: ${member.connect.c_code}<br>
	[U1]: ${member.connect.u1}<br>
	[U2]: ${member.connect.u2}<br>
	[d_status]: ${member.connect.d_status}<br>
	[d_limit]: ${member.connect.d_limit}<br>
	[d_uuid]: ${member.connect.d_uuid}<br><br>
	
	<button onclick="location.href='${pageContext.request.contextPath}/logout';">로그아웃</button>
	<button onclick="handleDisconnect('${member.uuid}');">연결끊기</button>
	<button onclick="handleDeleteMember('${member.uuid}');">회원탈퇴</button>
	<br><br>${member}
	
	
	<script src="${pageContext.request.contextPath}/js/utils.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/js/main.js" charset="utf-8"></script>
	<script>
		//account setting
		const onDeleteMember = function(uuid){
			utils.popupFormInitHelp();
			const passwd = document.querySelector("#d_passwd").value;
			if(passwd == ""){
				utils.popupFormCreateHelp(0, '- 비밀번호를 입력해주세요');
				return;
			}
		    $.ajax({
		        url: contextPath + "/deleteMember",
		        method: "post",
		        type: "json",
		        data: {uuid: uuid, passwd: passwd},
		        success: function(data) {
		        	console.log(data);
		        	if(data.result == "0"){
		        		utils.popupFormCreateHelp(0, '- 비밀번호가 일치하지 않습니다');
		        	}else if(data.result == "1"){
		        		utils.alert('정상적으로 회원탈퇴 되었습니다', contextPath+'/logout');
		        	}else if(data.result == "2"){
		        		utils.alert('문제가 발생했습니다. 로그아웃됩니다.', contextPath+'/logout');
		        	}
		        }
		    });
		}
		const handleDeleteMember = function(uuid){
			utils.popupForm('비밀번호 확인', 
					'<div>비밀번호<input type=\"password\" id=\"d_passwd\" name=\"d_passwd\"></div>', 
					'<button onclick=\"onDeleteMember(\''+uuid+'\')\">확인</button>');
		}
		
		const onDisconnect = function(uuid){
    		let form = document.createElement("form");
    		form.setAttribute("style", "display:none");
            form.setAttribute("charset", "UTF-8");
            form.setAttribute("method", "post");
            form.setAttribute("action", contextPath+"/disconnect");
            
            let hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", "uuid");
            hiddenField.setAttribute("value", uuid);
            form.appendChild(hiddenField);
            
            document.body.appendChild(form);
            form.submit();
		}
		const handleDisconnect = function(uuid){
			utils.alert('상대방과의 연결을 끊으시면 본 사이트에서 제공하는 서비스를 더 이상 이용하실 수 없습니다. <span style=\"color:#f7394f;\">그래도 연결해제를 원하시면 아래 회원탈퇴 버튼을 눌러주세요.</span> <span class=\"textSmall\"><br/>(이 메시지를 무시하려면 확인버튼을 눌러주세요)</span>',
					'',
					'<button onclick=\"onDisconnect(\''+uuid+'\');\" style=\"background-color:#f7394f;\">연결끊기</button>');
		}
	</script>
</body>
</html>