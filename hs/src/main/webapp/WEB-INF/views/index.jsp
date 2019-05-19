<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>하트시그널</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<link rel="apple-touch-icon" sizes="57x57" href="${pageContext.request.contextPath}/favicon/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="${pageContext.request.contextPath}/favicon/apple-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="72x72" href="${pageContext.request.contextPath}/favicon/apple-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/favicon/apple-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="114x114" href="${pageContext.request.contextPath}/favicon/apple-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="120x120" href="${pageContext.request.contextPath}/favicon/apple-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="144x144" href="${pageContext.request.contextPath}/favicon/apple-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="152x152" href="${pageContext.request.contextPath}/favicon/apple-icon-152x152.png">
	<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/favicon/apple-icon-180x180.png">
	<link rel="icon" type="image/png" sizes="192x192"  href="${pageContext.request.contextPath}/favicon/android-icon-192x192.png">
	<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="96x96" href="${pageContext.request.contextPath}/favicon/favicon-96x96.png">
	<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/favicon/favicon-16x16.png">
	<link rel="manifest" href="${pageContext.request.contextPath}/favicon/manifest.json">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="${pageContext.request.contextPath}/favicon/ms-icon-144x144.png">
	<meta name="theme-color" content="#ffffff">
	
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" >
	<link rel="stylesheet" href='https://fonts.googleapis.com/css?family=Roboto'>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" >
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/bootstrap/bootstrap.iso.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/fontawesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/material-datetime-picker/material-datetime-picker.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
	
	<script src="${pageContext.request.contextPath}/libs/jquery/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/libs/bootstrap/bootstrap.min.js"></script>
	<script src="https://unpkg.com/babel-polyfill@6.2.0/dist/polyfill.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.17.1/moment.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/rome/2.1.22/rome.standalone.js"></script>
	<script src="${pageContext.request.contextPath}/libs/material-datetime-picker/material-datetime-picker.js" charset="utf-8"></script>



	<!-- camera slider -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/libs/camera/camera.css">
	<script src="${pageContext.request.contextPath}/libs/jquery/jquery.easing.1.3.js"></script>
	<script src="${pageContext.request.contextPath}/libs/camera/camera.js"></script>

	<style>
		.wrap{position:relative; border:1px solid red; box-sizing: border-box; display:flex; justify-content: flex-start; flex-direction: column;}
		.wrap .header-top, .wrap .header, .wrap .content, .wrap .bottom{border:1px solid; display:flex; justify-content: center; box-sizing: border-box; -webkit-transition: all 300ms linear; -moz-transition: all 300ms linear; -o-transition: all 300ms linear; -ms-transition: all 300ms linear; transition: all 300ms linear;}
		.container-inner{position:relative; width:1170px;}
		
		
		/* 로그인 header영역 */
		.header-top{position: relative; padding: 0.5rem 0;}
		ul.login-menu{float:right; list-style: none; margin:0; padding:0; margin-right: 0.5rem;}
		ul.login-menu li{float:left; color:#5E5E5E; font-size: 0.75rem; transition: color .3s;}
		ul.login-menu li+li{margin-left: 0.5rem;}
		ul.login-menu li+li::before{content:'|'; color:#5E5E5E; margin-right: 0.5rem;}
		ul.login-menu li:hover a{color:#FF444F;}
		
		
		/* 메뉴영역 */
		.nav{clear:both; display:flex; flex-direction: row; justify-content: flex-start;}
		.nav .nav-bar{flex: 1; align-self:center; display: flex; justify-content: flex-end;}
		.section-logo {display: flex; align-items: center;}
		.section-logo img{ width: 12rem; }
		ul.nav-menu{list-style:none; margin:0; padding:0;}
		ul.nav-menu li{position:relative; float: left; border:1px solid;}
		ul.nav-menu li a{display:block; text-transform: uppercase; padding:2.8125rem 3.125rem; font-size:0.875rem; -webkit-transition: all 300ms linear; -moz-transition: all 300ms linear; -o-transition: all 300ms linear; -ms-transition: all 300ms linear; transition: all 300ms linear;}
    	ul.nav-menu li a:hover{color:#FF444F;}
    	ul.nav-menu li:hover ul{opacity: 1; z-index:1;}
    	ul.nav-menu li ul{opacity:0; z-index:-1; position:absolute; top:6.875rem; left:0; width:100%; border:1px solid; list-style:none; margin:0; padding:0; -webkit-transition: all 300ms linear; -moz-transition: all 300ms linear; -o-transition: all 300ms linear; -ms-transition: all 300ms linear; transition: all 300ms linear;}
    	ul.nav-menu li ul li{float: left; width:100%;}
    	

	</style>
</head>
<body>
	<span id="contextPathHolder" data-contextPath="${pageContext.request.contextPath}" style="display:none;"></span>
	<span id="connectLimit" data-connectLimit="${member.connect.d_limit}" style="display:none;"></span>
	
	
	
	

	
	
	
	<div class="wrap">
	
		<div class="header-top">
			<div class="container-inner">
				<ul class="login-menu">
					<li><a href="${pageContext.request.contextPath}/logout"><span class="fa fa-heartbeat"></span> 로그아웃</a></li>
					<li><a href="${pageContext.request.contextPath}/accountSetting"><span class="fa fa-cog"></span> 개인설정</a></li>
				</ul>
			</div>
		</div>
		<div class="header">
			<div class="container-inner">

				<div class="nav">
					<div class="section-logo"><img src="${pageContext.request.contextPath}/images/h_logo_bk.png" /></div>
					<div class="nav-bar">
						<ul class="nav-menu">
							<li><a href="#">D-day</a>
								<ul>
									<li>서브메뉴1</li>
									<li>서브메뉴2</li>
									<li>서브메뉴3</li>
								</ul>
							</li>
							<li><a href="#">체크리스트</a>
								<ul>
									<li>서브메뉴1</li>
									<li>서브메뉴2</li>
									<li>서브메뉴2</li>
								</ul>
							</li>
							<li><a href="#">발자취</a>
								<ul>
									<li>서브메뉴1</li>
								</ul>
							</li>
							<li><a href="#">하트게시판</a>
								<ul>
									<li>서브메뉴1</li>
									<li>서브메뉴1</li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="fluid_container">
	        <div class="camera_wrap camera_azure_skin" id="camera_wrap">
	            <div data-src="${pageContext.request.contextPath}/images/banner/1.jpg">
	                <div class="camera_caption fadeFromBottom">
	                    Camera is a responsive/adaptive slideshow. <em>Try to resize the browser window</em>
	                </div>
	            </div>
	            <div data-src="${pageContext.request.contextPath}/images/banner/2.jpg">
	            </div>
	            <div data-src="${pageContext.request.contextPath}/images/banner/3.jpg">
					<div class="fadeIn camera_effected caption-center" style="visibility: hidden; opacity: 1; color:#fff;" data-outerwidth="523" data-outerheight="198">
						<h1 class="caption-title">www.PopBle.com</h1>
						<p class="caption-cont hidden-xs">2016 ReNewal Versin<br>
						Since 2002 By 지옥의광대</p>
					</div>
	            </div>
	        </div>
        </div>
	    <script type="text/javascript">
			$(function(){
				$('#camera_wrap').camera();
			});
		</script>
		
		<div class="content">
			<div class="container-inner">
				<div>익명게시판 목록 & D-day & 데이트코스 추천API</div>
				<div>폴라로이드 형식사진 목록</div>
			</div>
		</div>
		<div class="bottom">
			<div class="container-inner">푸터</div>
		</div>
	</div>
	












	<script src="${pageContext.request.contextPath}/js/utils.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/js/main.js" charset="utf-8"></script>
</body>
</html>