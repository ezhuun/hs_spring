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
	
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap">
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
 
 
 
 
	<style>
		@media (max-width: 992px){
			.posts{width: 45% !important;}
			.posts:nth-child(n+3){margin-top: 2.5rem !important;}
		}
		@media (max-width: 768px){
			.header-top{
				display: none !important;
			}
			.header{
				display: none !important;
			}
			.banner-overlay::after{
				background:none !important;
			}
			.postbox{
				display: flex !important;
				margin: 0 !important;
				padding: 2rem 0 !important;
				align-items: center !important;
			    justify-content: center !important;
			    flex-direction: column !important;
			    height: auto !important;
			    background: linear-gradient(rgba(230,100,101,1), rgba(145,152,229,1)) !important;
			    box-shadow: inset 0px -55px 75px 97px #fff !important;
			}
			.posts{
				background: rgba(255,255,255,1) !important;
			    width: 75% !important;
			    height: 16.5rem !important;
			}
			.posts+.posts{
				margin-top: 2rem;
			}
			
			.m-header{
				display: flex !important;
			}
		}
	
		.wrap{position:relative; box-sizing: border-box; display:flex; justify-content: flex-start; flex-direction: column;}
		.header-wrap {background:#7b85a0; width:100%; height:100%; border-bottom:1px solid #b7b2b2;}
		.wrap .header-top, .wrap .header, .wrap .content, .wrap .bottom{position:relative; display:flex; flex-direction:row; justify-content: center;  flexbox-sizing: border-box; -webkit-transition: all 300ms linear; -moz-transition: all 300ms linear; -o-transition: all 300ms linear; -ms-transition: all 300ms linear; transition: all 300ms linear;}
		.wrap .header-top{background:rgba(0,0,0,0.3);}
		.container-inner{position:relative; width:1170px;}
		
		
		/* 로그인 header영역 */
		.header-top{position: relative; padding: 0.5rem 0;}
		ul.login-menu{float:right; list-style: none; margin:0; padding:0; margin-right: 0.5rem;}
		ul.login-menu li{float:left; color:#fff; font-size: 0.75rem; transition: color .3s;}
		ul.login-menu li+li{margin-left: 0.5rem;}
		ul.login-menu li+li::before{content:'|'; color:#5E5E5E; margin-right: 0.5rem;}
		ul.login-menu li:hover a{color:#FF444F;}
		
		
		/* 메뉴영역 */
		.nav{clear:both; display:flex; flex-direction: column; justify-content: flex-start; align-items: center;}
		.nav .nav-bar{flex: 1; align-self:center; display: flex; justify-content: flex-end;}
		.section-logo {display: flex; align-items: center; padding:2rem 0 0.5rem 0;}
		.section-logo img{ width: 12rem; }
		ul.nav-menu{list-style:none; margin:0; padding:0;}
		ul.nav-menu li{position:relative; float: left; }
		ul.nav-menu li a{display:block; text-transform: uppercase; color:#fff; padding:1.8125rem 3.125rem; font-size:0.875rem; -webkit-transition: all 300ms linear; -moz-transition: all 300ms linear; -o-transition: all 300ms linear; -ms-transition: all 300ms linear; transition: all 300ms linear;}
    	ul.nav-menu li a:hover{color:#FF444F;}
    	ul.nav-menu li:hover ul{opacity: 1; z-index:1;}
    	ul.nav-menu li ul{opacity:0; z-index:-1; position:absolute; top:4.75rem; left:0; width:100%; list-style:none; margin:0; padding:0; -webkit-transition: all 0.1s linear; -moz-transition: all 0.1s linear; -o-transition: all 0.1s linear; -ms-transition: all 0.1s linear; transition: all 0.1s linear;
    	background:rgba(255,255,255,1); box-shadow: 0px 4px 15px 1px rgba(0, 0, 0, 0.2); border-radius:0.125rem; border-top:2px solid #ff6c75;}
    	ul.nav-menu li ul::after{content:''; position:absolute; top:-0.425rem; left:45%; border-top:0.425rem solid none; border-bottom:0.425rem solid #ff6c75; border-right: 0.425rem solid transparent; border-left: 0.425rem solid  transparent; }
    	ul.nav-menu li ul li{float: left; color:#333; font-size: 0.785rem; box-sizing:border-box; width:100%; padding: 0.425rem 0.125rem; cursor:pointer;}
    	ul.nav-menu li ul li::after{content:''; position:absolute; bottom:0; left:0; width:0; height:0.125rem; background-color:#efefef; transition: all 0.3s ease-in;}
    	ul.nav-menu li ul li:hover::after{width:100%;}
    	
    	.banner-overlay{position:absolute; width:100%; height:37.5rem;}
    	.banner-overlay::after{content:''; position:absolute; top:0; left:0; width:100%; height:100%;
    	background:url('${pageContext.request.contextPath}/images/loginbg.png');
    	background-size: 75% 100%;}
		.postbox{padding: 0 0.5rem; position:relative; margin:1rem 0;}
		.posts{vertical-align: top; box-sizing: border-box; display: inline-flex; width:23%; flex-direction: column; height:16.5rem !important; padding:1rem 1rem 2rem; flex:1; height:100%; transform: rotate(-3deg); background:rgba(255,255,255,0.7); box-shadow: 0px 4px 15px 1px rgba(0, 0, 0, 0.2);}
		.posts+.posts{margin-left:1rem;}
		
		.posts:nth-child(1n){transform: rotate(3deg);}
		.posts:nth-child(2n){transform: rotate(0deg);}
		.posts:nth-child(3n){transform: rotate(-3deg);}
		.posts::after{content:' '; position:absolute; top:-1rem; left:45%; height:2rem; border:0.375rem solid; border-color: rgba(115, 105, 105,.7);}
		.post-photo{width:100%; height:100%; box-shadow: 0px 7px 28px -8px rgba(0, 0, 0, 0.2); display:flex; justify-content: center; align-items:center; font-size:0.825rem;}
		.post-photo img{
		    width: auto;
		    height: auto;
		    max-width: 100%;
		    max-height: 100%;
 		   }
		.post-title {width:100%;}
		.post-title span{}
		
		.m-header{
display: none;
    flex-direction: row;
    justify-content: center;
    background-color: #fff;
    align-items: center;
    color:#999;
		}
		.m-header .section-logo{margin:0.5rem 0; padding:0;}
		.m-header .section-logo img{width:8rem;}
		.m-header .left-menu-toggle{position:absolute; left:1rem; cursor:pointer;}
		
		
		.left-menu-container{
			width: 16.25rem;
		    position: fixed;
		    left: -16.25rem;
		    top: 0;
		    height: 100%;
		    z-index: 2;
		    background: rgba(255,255,255,2);
		    box-sizing: border-box;
		    border-right: 1px solid #E5E5E5;
		    transition: all .3s linear;
		    display: flex;
		    justify-content: flex-start;
		    flex-direction: column;
		}
		.left-menu-top{
			height:2.926875rem;
			border-bottom: 1px solid #E5E5E5;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    width: 100%;
		}
		.left-menu-top .fa{
			position: absolute;
			left: 1rem;
			color: #777;
			cursor: pointer;
		}
		.left-menu-top img{
			width: 7rem;
		}

		.left-menu-auth{
			border-bottom: 1px solid #E5E5E5;
			height: 5rem;
			width: 100%;
			display: flex;
			justify-content: center;
		}
		.left-menu-auth div{
			flex: 1;
			color:#777;
			display: flex;
			justify-content: center;
			align-items: center;
			flex-direction: column;
			cursor:pointer;
			font-size: 0.875rem;
			font-weight: 600;
		}
		.left-menu-auth div .fa{
			display:block;
		}
		.left-menu-auth div+div{
			border-left: 1px solid #E5E5E5;
		}
		.left-menu-items > .nav-bar ul.nav-menu li{
			width: 100%;
		}
		.left-menu-items > .nav-bar ul.nav-menu li+li{
			border-top: 1px solid #e5e5e5;
		}
		.left-menu-items > .nav-bar ul.nav-menu li:last-child{
			border-bottom: 1px solid #e5e5e5;
		}
		.left-menu-items > .nav-bar ul.nav-menu li a{
		    padding: 0.8125rem 2.125rem;
			color:#333;
			font-weight: 600;
		}
		.left-menu-items > .nav-bar ul.nav-menu li ul::after{
			all: unset;
		}
		.left-menu-items > .nav-bar ul.nav-menu li ul{
			all: unset;
			position: relative;
		}
		.left-menu-items > .nav-bar ul.nav-menu li ul li::after{
			all: unset;
		}
		.left-menu-items > .nav-bar ul.nav-menu li ul li{
			padding: 0.425rem 3.125rem;
			font-weight: normal;
		}
		.left-menu-items > .nav-bar ul.nav-menu li ul li+li{
			border-top: none;
		}
		.left-menu-items > .nav-bar ul.nav-menu li ul li:last-child{
			border-bottom: none;
		}
		    
	</style>
</head>
<body>
	<span id="contextPathHolder" data-contextPath="${pageContext.request.contextPath}" style="display:none;"></span>
	<span id="connectLimit" data-connectLimit="${member.connect.d_limit}" style="display:none;"></span>
 
 
	
	
	
	<div class="wrap">
		<div class="left-menu-container">
			<div class="left-menu-top"><span class="fa fa-times" onclick="handleClickToggleClose();"></span><img src="${pageContext.request.contextPath}/images/h_logo_bk.png" /></div>
			<div class="left-menu-auth">
				<div class="auth-logout" onclick="location.href='${pageContext.request.contextPath}/logout';"><span class="fa fa-sign-out"></span>로그아웃</div>
				<div class="auth-setting" onclick="location.href='${pageContext.request.contextPath}/accountSetting';"><span class="fa fa-cog"></span>개인설정</div>
			</div>
			<div class="left-menu-items">
				<div class="nav-bar">
					<ul class="nav-menu">
						<li><a href="#">D-day</a></li>
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
					</ul>
				</div>
			</div>
		</div>
		
		
		<div class="header-wrap">
			<div class="m-header">
				<div class="left-menu-toggle"><span class="fa fa-bars" onclick="handleClickToggleOpen();"></span></div>
				<div class="section-logo"><img src="${pageContext.request.contextPath}/images/h_logo_bk.png" /></div>
			</div>
		
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
						<div class="section-logo"><img src="${pageContext.request.contextPath}/images/h_logo.png" /></div>
						<div class="nav-bar">
							<ul class="nav-menu">
								<li><a href="#">D-day</a></li>
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
								<li><a href="#">익명게시판</a>
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
		</div>
		
 
		<div class="content">
			<div class="banner-overlay"></div>
			<div class="container-inner">
				<div class="postbox">
					<div class="posts">
						<div class="post-photo">
							<img src="${pageContext.request.contextPath}/images/banner/1.jpg" />
						</div>
						<div class="post-title">제목제목11</div>
					</div>
					<div class="posts">
						<div class="post-photo">
							<img src="${pageContext.request.contextPath}/images/banner/2.jpg" />
						</div>
						<div class="post-title">제목제목22</div>
					</div>
					<div class="posts">
						<div class="post-photo">
							당신의 이야기를 작성하세요
						</div>
						<div class="post-title"></div>
					</div>
					<div class="posts">
						<div class="post-photo">
							<img src="${pageContext.request.contextPath}/images/banner/4.jpg" />
						</div>
						<div class="post-title">
							<span>제목제목33</span>
						</div>
					</div>
				</div>
				
				<div>여기 어때요?</div>
				
				<div>익명게시판 목록 & D-day</div>
			</div>
		</div>
		<div class="bottom">
			<div class="container-inner"></div>
		</div>
	</div>
	
 
 
 
 
 
 
 
 
 
 
 
 
	<script src="${pageContext.request.contextPath}/js/utils.js" charset="utf-8"></script>
	<script src="${pageContext.request.contextPath}/js/main.js" charset="utf-8"></script>
	<script>
	const handleClickToggleClose = function(){
		const left = document.querySelector(".left-menu-container");
		left.style.left = "-16.25rem";
	}
	const handleClickToggleOpen = function(){
		const left = document.querySelector(".left-menu-container");
		left.style.left = "0";
	}
	
	
	var mql = window.matchMedia("screen and (max-width: 768px)");
	mql.addListener(function(e) {
		handleClickToggleClose();
	});
	</script>
</body>
</html>