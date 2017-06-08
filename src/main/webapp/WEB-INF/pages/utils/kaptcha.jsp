<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>H+ 后台主题UI框架 - 图形验证码</title>
    <meta name="keywords" content="H+后台主题,后台bootstrap框架,会员中心主题,后台HTML,响应式后台">
    <meta name="description" content="H+是一个完全响应式，基于Bootstrap3最新版本开发的扁平化主题，她采用了主流的左右两栏式布局，使用了Html5+CSS3等现代技术">

    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="${ctx}/plugins/animate/animate.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    <link href="${ctx}/plugins/hplus/style.min.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
    	<div class="form-group">
		    <img style="display:inline;" id="kaptcha-img" src="kaptcha.jpg" title="点击更换"/>
		    <input type="text" name="kaptcha" id="kaptcha"> 
		    <button id="check">验证</button> 
		</div>
	</div>	

    <script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
    
	<script>
		var $kaptcha_img = $("#kaptcha-img");
		var $kaptcha = $("#kaptcha");
		
		$kaptcha_img.click(function() {
			$(this).attr("src","kaptcha.jpg?t=" + Math.random()); 
		});
		
		$("#check").click(function() {
			$.ajax({
				url: "${ctx}/check",
				type: "POST",
				data: {
					kaptcha: $kaptcha.val()
				},
				success: function(data) {
					if (data.code == 0) {
						swal('', '验证成功!', 'success');
					} else {
						$kaptcha_img.attr("src","kaptcha.jpg?t=" + Math.random()); 
						$kaptcha.val("");
					}
				},
				error: function(err) {}
			});
		});
    </script>
</body>

</html>