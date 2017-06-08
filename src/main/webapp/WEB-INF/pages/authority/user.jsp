<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Template -- 用户管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css"> 
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	
</head>

<body class="gray-bg body-user">
	<div class="wrapper wrapper-content animated fadeInRight">
	 	<div class="ibox float-e-margins">
	 		<div class="ibox-title">
	 			<h5>用户管理</h5>
	 		</div>
	 		<div class="ibox-content">
 				<div class="btn-group hidden-xs" id="user-list-table-toolbar" role="group">
 					<button type="button" class="btn btn-outline btn-default btn-user-add" data-toggle="modal" data-target="#modal-user-dialog">
 						<i class="fa fa-plus fa-fw"></i>新增
 					</button>
 					<button type="button" class="btn btn-outline btn-default btn-user-delete-batch" disabled='disabled'>
 						<i class="fa fa-trash-o fa-fw"></i>批量删除
 					</button>
 				</div>
 				<table id="user-list-table" data-mobile-responsive="true"> </table>
	 		</div>
	 	</div>
	
	</div>
	
	<!-- 用户新增,编辑对话框 -->
	<div class="modal" id="modal-user-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content animated fadeInDown">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title"><strong></strong></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="form-user" autocomplete="off">
						<div class="form-group">
							<label for="username" class="col-sm-3 control-label"><i class="form-required">*</i>用户名</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="username" required>
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-3 control-label"><i class="form-required">*</i>密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" name="password" required>
							</div>
						</div>
						<div class='form-group'>
   							<label for='mobile' class='col-sm-3 control-label'><i class="form-required">*</i>联系电话</label>
    						<div class='col-sm-7'>
      							<input type='text' class='form-control' name='mobile' required>
    						</div>
      					</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline btn-default" data-dismiss="modal">
						<i class="fa fa-close fa-fw"></i>关闭
					</button>
					<button type="button" class="btn btn-outline btn-primary btn-confirm">
						<i class="fa fa-check fa-fw"></i>确定
					</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/language/zh_CN.js"></script>
	
	<script type="text/javascript">
	;(function( $ ) {
		
		var $page = $('.body-user');
		var $userDialog = $page.find('#modal-user-dialog');
		var $userForm = $userDialog.find('form');
		
		var $table = $k.util.bsTable($page.find('#user-list-table'), {
			url: '${ctx}/api/user/list',
			toolbar: '#user-list-table-toolbar',
			idField: 'id',
			responseHandler: function(res) {
				return res.data;
			},
			columns: [
			{
				field: 'state',
				checkbox: true
			},			          
			{
				field: 'username',
				title: '用户名',
				align: 'center'
			},
			{
				field: 'mobile',
				title: '手机号码',
				align: 'center'
			},
			{
				field: 'email',
				title: '邮箱',
				align: 'center',
			},
			{
				field: 'status',
				title: '状态',
				align: 'center',
 				formatter: function(value, row, index) {
					if (row['status'] == 0) {
						return '<span class="label label-primary">启用</span>';
					}
					if (row['status'] == 1) {
						return '<span class="label label-danger">禁用</span>';
					}
					return value;
				}, 
			},
			{
				title: '操作',
				align: 'center',
				events: window.operateEvents = {
					'click .btn-user-detail': function(e, value, row, index) {
						
					},
					'click .btn-user-edit': function(e, value, row, index) {  
						
					},
					'click .btn-user-delete': function(e, value, row, index) {
						swal({
							title: '',
							text: '确定删除选中用户',
							type: 'warning',
							showCancelButton: true,
							cancelButtonText: '取消',
							confirmButtonColor: '#DD6B55',
							confirmButtonText: '确定',
							closeOnConfirm: false
						}, function() {
							var userId = row['id'];
							
							$.ajax({
								url: '${ctx}/api/user/delete',
								data: { 
									userId: userId
								},
								success: function(ret) {
									if (ret.code == '0') {
										swal('', '删除成功!', 'success');
									} else {
										swal('', ret.msg, 'error');
									}
									$table.bootstrapTable('refresh'); 
								},
								error: function(err) {}
							});
						});
					}
				},
				formatter: function(value, row, index) {
					return '<a class="btn-user-detail">详情</a> | ' + '<a class="btn-user-edit">编辑</a> | ' + '<a class="btn-user-delete">删除</a>';
				}
			}
			]
		});
		
		$table.on('all.bs.table', function(e, row) {
			var selNum = $table.bootstrapTable('getSelections').length;
			selNum > 0 ? $page.find('.btn-user-delete-batch').removeAttr('disabled') : $page.find('.btn-user-delete-batch').attr('disabled', 'disabled');
		});
		
		$page
		.on('hidden.bs.modal', '#modal-user-dialog', function() {
			$userForm.bootstrapValidator('resetForm', true);
			$(this).removeData('bs.modal');
		})
		.on('click', '.btn-user-add', function() {
			$userDialog.find('.modal-title strong').text('新增');
			$userForm.find('input[name = "password"]').closest('.form-group').show();
			$userForm.find('input').removeAttr('disabled');
			
			$userDialog.on('click', '.btn-confirm', function() {
				var bootstrapValidator = $userForm.data('bootstrapValidator');
				bootstrapValidator.validate();
				
				if (bootstrapValidator.isValid()) {
					$.ajax({
						url: '${ctx}/api/user/add',
						type: 'POST',
						data: {
							username: $userForm.find('input[name = "username"]').val(),
							password: $userForm.find('input[name = "password"]').val(),
							mobile: $userForm.find('input[name = "mobile"]').val()
						},
						success: function(ret) {
							$userDialog.modal('hide');
							swal('', '添加成功!', 'success');
							$table.bootstrapTable('refresh'); 
						},
						error: function(err) {}
					});
				}
			});
		})
		.on('click', '.btn-user-edit', function() {
			$userDialog.find('.modal-title strong').text('编辑');
			var row = $table.bootstrapTable('getSelections')[0];
			$.each(row, function(key, val) {
				if (key == 'password') {
					$userForm.find('input[name = "password"]').attr('disabled', 'disabled');
					$userForm.find('input[name = "password"]').closest('.form-group').hide();
				} else if (key == 'username') {
					$userForm.find('input[name = "username"]').attr('disabled', 'disabled');
				}
				$userForm.find('input[name="' + key + '"]').val(val);
			});
			
			$userDialog.on('click', '.btn-confirm', function() {
				var bootstrapValidator = $userForm.data('bootstrapValidator');
				bootstrapValidator.validate();
				
				if (bootstrapValidator.isValid()) {
					$.ajax({
						url: '${ctx}/api/user/edit',
						type: 'POST',
						data: {
							userId: row.id,
							mobile: $userForm.find('input[name = "mobile"]').val()
						},
						success: function(ret) {
							$userDialog.modal('hide');
							swal('', '编辑成功!', 'success');
							$table.bootstrapTable('refresh'); 
						},
						error: function(err) {}
					});
				}
			});
		})
		.on('click', '.btn-user-delete-batch', function() {
			swal({
				title: '',
				text: '确定批量删除选中记录',
				type: 'warning',
				showCancelButton: true,
				cancelButtonText: '取消',
				confirmButtonColor: '#DD6B55',
				confirmButtonText: '确定',
				closeOnConfirm: false
			}, function() {
				var rows = $table.bootstrapTable('getSelections');
				
				$.ajax({
					url: '${ctx}/api/user/deleteBatch',
					data: { 
						userIds: $k.util.getIds(rows) 
					},
					success: function(ret) {
						if (ret.code == '0') {
							swal('', '删除成功!', 'success');
						} else {
							swal('', ret.msg, 'error');
						}
						$table.bootstrapTable('refresh'); 
					},
					error: function(err) {}
				});
			});
		});
		
		// 添加验证器
		$userDialog.find('form').bootstrapValidator({
			message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            excluded: [':disabled'],
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
				mobile: {
	                 validators: {
 	                     regexp: {
	                         regexp: /^1[3|5|8]{1}[0-9]{9}$/,
	                         message: '请输入正确的手机号码'
	                     } 
	                 }
	             }
			}
		});
		
		window.operateEvents = {
				'click .user-edit': function(e, value, row, index) {      
			       debugger;
			    }
			}
		
	})( jQuery );
	</script>
	
</body>

</html>