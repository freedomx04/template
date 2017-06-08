<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>Template -- 详情</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">

	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">

</head>

<body class="gray-bg body-article-detail">
	<div class="wrapper wrapper-content animated fadeInRight article">
		<div class="spiner-example hm-loading">
			<div class="sk-spinner sk-spinner-wandering-cubes">
				<div class="sk-cube1"></div>
				<div class="sk-cube2"></div>
			</div>
        </div>	
	
	 	<div class="ibox float-e-margins content-article-detail hidden">
	 		<div class="ibox-title">
	 			<button type="button" class="btn btn-outline btn-default btn-article-back"><i class="fa fa-reply fa-fw"></i>返回</button>
	 			<div class="ibox-tools">
	 				<button type="button" class="btn btn-outline btn-primary btn-article-avorite"><i class="fa fa-star fa-fw"></i>收藏</button> 				
	 			</div>	 			
	 		</div>
 			<div class="ibox-content">
 				<div class="text-center article-title"><h1></h1></div>
 				
 				<div class="hm-article-info">
 					<div class="hm-article-info-base">
 						<span class="article-source"></span>
 						<span class="article-user"></span>
 						<span class="article-updateTime text-muted"></span>
 					</div>
 					
 					<div class="hm-article-info-extra">
 						评论： 11
 					</div>
 				</div>
 				
 				<div class="article-content"></div>
 			</div>
	 	</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>

	<script type="text/javascript">
	
		var $page = $('.body-article-detail');
		
		var articleId = $k.util.getRequestParam('id');
		
		$.ajax({
			url: '${ctx}/api/article/detail',
			data: {
				articleId: articleId
			},
			success: function(ret) {
				if (ret.code == 0) {
					var article = ret.data;
					$page.find('.article-title h1').text(article.title);
					
					$page.find('.article-source').text(article.source);
					$page.find('.article-user').text('孙某某');
					$page.find('.article-updateTime').text(formatDate2(article.updateTime));
					
					$page.find('.article-content').html(article.content);
					
					$page.find('.hm-loading').remove();
					$page.find('.content-article-detail').removeClass('hidden');
				}
			},
			error: function(err) {
				
			}
		});
		
		$page.on('click', '.btn-article-back', function() {
			window.location.href = './articleList';
		});
		
	</script>

</body>

</html>