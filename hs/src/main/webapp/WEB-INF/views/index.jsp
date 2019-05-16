<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/lib/jquery-3.4.1.min.js"></script>
</head>
<body>
	<span id="contextPathHolder" data-contextPath="${pageContext.request.contextPath}" style="display:none;"></span>
	
	<h4>나의정보</h4><br>
	[UUID]: ${member.uuid}<br>
	[EMAIL]: ${member.email}<br>
	[NAME]: ${member.name}<br>
	[C_CODE]: ${member.c_code}<br><br>
	
	<h4>상대방정보</h4><br>
	[UUID]: ${member.lover.uuid}<br>
	[EMAIL]: ${member.lover.email}<br>
	[NAME]: ${member.lover.name}<br>
	[C_CODE]: ${member.lover.c_code}<br><br>
	
	<h4>연결정보</h4><br>
	[C_CODE]: ${member.connect.c_code}<br>
	[U1]: ${member.connect.u1}<br>
	[U2]: ${member.connect.u2}<br>
	[d_status]: ${member.connect.d_status}<br>
	[d_limit]: ${member.connect.d_limit}<br>
	[d_uuid]: ${member.connect.d_uuid}<br><br>
	
	<button onclick="location.href='${pageContext.request.contextPath}/logout';">로그아웃</button>
	<button onclick="handleDisconnect('${member.uuid}', '${member.c_code}');">연결끊기</button>
	<button onclick="handleDeleteMember('${member.uuid}');">회원탈퇴</button>
	<br><br>${member}
	
	<script src="${pageContext.request.contextPath}/js/utils.js" charset="utf-8"></script>
	<script>
		const handleDisconnect = function(uuid, code){
			if(confirm('상대방과의 연결을 끊으시면 본 사이트에서 제공하는 서비스를 더 이상 이용하실 수 없습니다. 그래도 연결을 해제하시겠습니까?')){
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
                
                hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", "code");
                hiddenField.setAttribute("value", code);
                form.appendChild(hiddenField);
                
                document.body.appendChild(form);
                form.submit();
			}
		}
		
		const handleDeleteMember = function(){
			alert('준비중');
		}
	</script>
</body>
</html>