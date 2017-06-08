<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>Template -- 登录</title>

	<!-- <link rel="shortcut icon" href="favicon.ico"> -->
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/webui-popover/jquery.webui-popover.min.css">
	
</head>

<body class="gray-bg">

	<div class="middle-box text-center loginscreen animated fadeInDown">
		<div>
			<div>
				<h1 class="logo-name">Te</h1>
			</div>
			 <h3>欢迎使用</h3>
			
			<form class="m-t login-form" role="form" action="">
				<div class="form-group">
					<label class="username-not-exist sr-only" for="form-username" data-placement="top" data-content="输入的用户不存在"></label>
					<label class="username-empty sr-only" for="form-username" data-placement="top" data-content="请输入用户名"></label>
					<input type="text" class="form-control form-username" placeholder="用户名">
				</div>
				
				<div class="form-group">
					<label class="password-error sr-only" for="form-password" data-placement="top" data-content="输入的密码错误"></label> 
					<label class="password-empty sr-only" for="form-password" data-placement="top" data-content="请输入密码"></label>
					<input type="password" class="form-control form-password" placeholder="密码">
				</div>
				
				<button type="submit" class="btn btn-primary block full-width m-b">登 录</button>
				
				<p class="text-muted text-center">
					<a href="#">忘记密码了？</a> | <a href="register">注册一个新账号</a>
				</p>
				
			</form>
		</div>
	</div>
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/webui-popover/jquery.webui-popover.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript">
		
		var $loginForm = $('.login-form');
		
		var username = $k.util.getRequestParam('username');
		$loginForm.find('.form-username').val(username);
		
		$loginForm.submit(function(e) {
			var username = 	$loginForm.find(".form-username").val();
			var password = $loginForm.find(".form-password").val();
			if (username == '') {
				$loginForm.find('.username-empty').webuiPopover().trigger('click');
				return false;
			}
			if (password == '') {
				$loginForm.find('.password-empty').webuiPopover().trigger('click');
				return false;
			}
			
 			$.ajax({
				url: '${ctx}/api/user/login',
				type: 'POST',
				data: {
					username: username,
					password: password
				},
	          	success: function(data) {
	          		switch (data.code) {
	          		case 0:		window.location.href = "./home";		break;
	          		case 1002:	$loginForm.find('.username-not-exist').webuiPopover().trigger('click');	break;
	          		case 2001:	$loginForm.find('.password-error').webuiPopover().trigger('click');		break;
	          		default:	break;
	          		}
	          	}, 
	          	error: function(err) {}
			}); 
			
			return false;
		});
	
	</script>
</body>

</html>