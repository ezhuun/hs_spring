<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title><tiles:getAsString name="title"/></title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">
	<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/material-datetime-picker.css">
	
	<script src="${pageContext.request.contextPath}/lib/jquery-3.4.1.min.js"></script>
	<script src="https://unpkg.com/babel-polyfill@6.2.0/dist/polyfill.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/rome/2.1.22/rome.standalone.js"></script>
	<script src="${pageContext.request.contextPath}/lib/material-datetime-picker.js" charset="utf-8"></script>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
	<span id="contextPathHolder" data-contextPath="${pageContext.request.contextPath}" style="display:none;"></span>
	<tiles:insertAttribute name="body" />
</body>
</html>


