<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>Template -- 注册</title>

	<!-- <link rel="shortcut icon" href="favicon.ico"> -->
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">

</head>

<body class="gray-bg">

	<div class="middle-box loginscreen animated fadeInDown">
	 	<div>
	 		<div class="text-center">
	 			<h1 class="logo-name">Te</h1>
	 		</div>
	 		<h3 class="text-center">欢迎注册</h3>
	 		
	 		<form class="m-t register-form" role="form" autocomplete="off" action="">
	 			<div class="form-group">
	 				<input type="text" class="form-control" name="username" placeholder="请输入用户名" required>
	 			</div>
	 			
	 			<div class="form-group">
	 				<input type="password" class="form-control" name="password" placeholder="请输入密码" required>
	 			</div>
	 			
	 			<div class="form-group">
	 				<input type="password" class="form-control" name="repassword" placeholder="请再次输入密码" required>
	 			</div>
	 			
	 			<div class="form-group">
	 				<input type="text" class="form-control" name="telephone" placeholder="联系电话" required>
	 			</div>
	 			
	 			<button type="submit" class="btn btn-primary block full-width m-b">注 册</button>
	 			
	 			<p class="text-muted text-center"><small>已经有账户了？</small><a href="login">点此登录</a></p>
	 		</form>
	 	</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/language/zh_CN.js"></script>
	
    <script type="text/javascript">
    	
    	var $registerForm = $('.register-form');
    	
    	$registerForm.submit(function(e) {
    		var bootstrapValidator = $registerForm.data('bootstrapValidator');
    		
    		if (bootstrapValidator.isValid()) {
    			$.ajax({
					url: '${ctx}/api/user/add',
					data: {
						username: $registerForm.find('input[name = "username"]').val(),
						password: $registerForm.find('input[name = "password"]').val(),
						telephone: $registerForm.find('input[name = "telephone"]').val()
					},
					success: function(ret) {
						swal({
							title: '',
							text: '注册成功, 跳转到登录页面',
							type: 'success'
						}, function() {
							window.location.href = "./login?username=" + $registerForm.find('input[name = "username"]').val();
						});
					},
					error: function(err) {}
				});
    		} 
    		
    		return false;
    	});
    	
    	$registerForm.bootstrapValidator({
    		message: 'This value is not valid',
    		feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
            	username: {
            		validators: {
            			stringLength: {
            				min: 6,
            				max: 20,
            				message: '用户名长度必须在6到20之间'
            			},
            			threshold: 6,
                        remote: {
                        	url: '${ctx}/api/user/exist',
                           	message: '用户已存在',
                           	delay: 2000,
                           	type: 'GET',
                        }
            		}
            	},
            	password: {
            		validators: {
            			stringLength: {
            				min: 6,
            				max: 20,
            				message: '密码长度必须在6到20之间'
            			}
            		}
            	},
            	repassword: {
            		validators: {
            			identical: {
            				field: 'password',
                            message: '两次密码不一致'
                        }
            		}
            	},
                telephone: {
                    validators: {
                        regexp: {
                            regexp: /^1[3|5|8]{1}[0-9]{9}$/,
                            message: '请输入正确的手机号码'
                        } 
                    }
                }
            }
    	});
    	
    </script>

</body>

</html>