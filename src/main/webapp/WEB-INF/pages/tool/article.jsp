<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>Template -- 文章</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/summernote/summernote.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/summernote/summernote-bs3.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	
</head>

<body class="gray-bg body-article">
	<div class="wrapper wrapper-content">
		<div class="spiner-example hm-loading">
			<div class="sk-spinner sk-spinner-wandering-cubes">
				<div class="sk-cube1"></div>
				<div class="sk-cube2"></div>
			</div>
        </div>		
	
	 	<div class="ibox float-e-margins content-article hidden">
	 		<div class="ibox-title">
	 			<h5><span class="article-type"></span></h5>
	 			<div class="ibox-tools">
	 				<a class="collapse-link">
	 					<i class="fa fa-chevron-up fa-fw"></i>
	 				</a>	 				
	 			</div>
	 		</div>
	 		<div class="ibox-content">
 	 			<div class="btn-group hm-btn-group">
	 				<button type="button" class="btn btn-outline btn-default btn-article-back"><i class="fa fa-reply fa-fw"></i>返回</button>
	 				<button type="button" class="btn btn-outline btn-default btn-article-add hidden"><i class="fa fa-check fa-fw"></i>确定</button>
	 				<button type="button" class="btn btn-outline btn-default btn-article-edit hidden"><i class="fa fa-save fa-fw"></i>保存</button>
	 			</div>
	 			
	 			<hr class="hm-hr">
	 			
	 			<div>
	 				<form class="form-article form-horizontal" role="form" autocomplete="off">
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label"><i class="form-required">*</i>文章标题</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="title" required>
							</div>
						</div>	
						 <div class="form-group">
							<label for="source" class="col-sm-2 control-label">文章来源</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="source">
							</div>
						</div>
						<div class="form-group" >
							<label for="source" class="col-sm-2 control-label">文章详细内容</label>
							<div class="col-sm-10">
								<div id="summernote"></div>
							</div>
						</div>		 
	 				</form>
	 			</div>  
	 		</div>
	 	</div>
	
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/summernote/summernote.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/summernote/lang/summernote-zh-CN.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/language/zh_CN.js"></script>

	<script type="text/javascript">
	
		var $page = $('.body-article');
		var $form = $page.find('.form-article');
		$k.util.bootstrapValidator($form);
		
		// 获取文章操作类型和文章ID
		var type = $k.util.getRequestParam('type');
		var articleId = $k.util.getRequestParam('id');
		
		if (type == 'add') {
			$page.find('.btn-article-add').removeClass('hidden');
			$page.find('.article-type').text('文章新增');
			
			$('#summernote').summernote({
				minHeight: 360,
				lang: 'zh-CN',
				focus: true,
				dialogsFade: true,
				placeholder: '文章内容'
			});
			
			$page.find('.hm-loading').remove();
			$page.find('.content-article').removeClass('hidden');
		} else if (type == 'edit') {
			$.ajax({
				url: '${ctx}/api/article/detail',
				data: {
					articleId: articleId
				},
				success: function(ret) {
					if (ret.code == 0) {
						$page.find('.btn-article-edit').removeClass('hidden');
						$page.find('.article-type').text('文章编辑');
						
						var article = ret.data;
						$form.find('input[name="title"]').val(article.title);
						$form.find('input[name="source"]').val(article.source);
						$('#summernote').summernote({
							minHeight: 360,
							lang: 'zh-CN',
							focus: true,
							dialogsFade: true,
						});
						$('#summernote').summernote('code', article.content);
						
						$page.find('.hm-loading').remove();
						$page.find('.content-article').removeClass('hidden');
					}
				},
				error: function(err) {
					swal('', err.statusText, 'error');
				}
			});
		}
		
		$page
		.on('click', '.btn-article-back', function() {
			window.location.href = './articleList';
		})
		.on('click', '.btn-article-add', function() {
			var bsValidator = $form.data('bootstrapValidator');
			bsValidator.validate();
			
			if (bsValidator.isValid()) {
	 			$.ajax({
					url: '${ctx}/api/article/add',
					type: 'POST',
					data: {
						title: $form.find('input[name="title"]').val(),
						source: $form.find('input[name="source"]').val(),
						content: $('#summernote').summernote('code')
					},
					success: function(ret) {
						if (ret.code == '0') {
							swal({
								title: '',
								text: '添加成功',
								type: 'success'
							}, function() {
								window.location.href = './articleList';
							});
						}
					},
					error: function(err) {
						swal('', err.statusText, 'error');
					}
				}); 
			}
		})
		.on('click', '.btn-article-edit', function() {
			var bsValidator = $form.data('bootstrapValidator');
			bsValidator.validate();
			
			if (bsValidator.isValid()) {
	 			$.ajax({
					url: '${ctx}/api/article/edit',
					type: 'POST',
					data: {
						articleId: articleId,
						title: $form.find('input[name="title"]').val(),
						source: $form.find('input[name="source"]').val(),
						content: $('#summernote').summernote('code')
					},
					success: function(ret) {
						if (ret.code == '0') {
							swal({
								title: '',
								text: '编辑成功',
								type: 'success'
							}, function() {
								window.location.href = './articleList';
							});
						}
					},
					error: function(err) {
						swal('', err.statusText, 'error');
					}
				}); 
			}
		});
		
	</script>
</body>

</html>