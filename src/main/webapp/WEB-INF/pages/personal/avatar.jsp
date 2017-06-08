<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>修改头像</title>

	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/cropper/cropper.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">

</head>

<body class="gray-bg body-modify-avatar">
	<div class="wrapper wrapper-content">
	 	
		<div class="ibox float-e-margins">
			<div class="ibox-title">
				<h5>修改头像</h5>
			</div>
			
			<div class="ibox-content">
	             <div class="row">
	                 <div class="col-sm-6">
	                     <div class="image-crop" style="padding: 0 20px;">
	                         <img style="width: 100%; height:auto;">
	                     </div>
	                 </div>
	                 <div class="col-sm-6">
	                     <h4>图片预览：</h4>
	                     <div class="row">
							<div class="col-sm-6">
								<div class="img-preview"></div>
							</div>
							<div class="col-sm-4">
								<div class="img-preview"></div>
							</div>
							<div class="col-sm-2">
								<div class="img-preview"></div>
							</div>
	                     </div>
	                     <h4>说明：</h4>
	                     <p> 你可以选择新图片上传，然后保存裁剪后的图片</p>
	                     <div>
	                         <label for="inputImage" class="btn btn-primary" title="选择图片">
	                             <input type="file" accept="image/*" name="file" id="inputImage" class="hide">
	                             	<i class="fa fa-upload fa-fw"></i>选择图片
	                         </label>
	                         <label id="upload" class="btn btn-primary" title="保存头像">
	                         	<i class="fa fa-save fa-fw"></i>保存头像
	                         </label>
	                     </div>
	                 </div>
	             </div>
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/cropper/cropper.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
	
	<script>
	;(function( $ ) {
		var $image = $(".image-crop > img");
		var $previews = $('.img-preview');
		var $inputImage = $("#inputImage");
		var $upload = $("#upload");
		
		$.ajax({
			url: "api/user/detail",
			type: "GET",
			data: {
				userId: 1
			},
			success: function(data) {
				if (data.code == 0) {
					if (data.data.avatarPath == null) {
						$image.attr("src", "${ctx}/img/default-user.jpg");
					} else {
						$image.attr("src", "${ctx}" + "/" + data.data.avatarPath);
					}
					
					$image.cropper({
			    		aspectRatio: 1,
			    		built: function (e) {
			            	var $clone = $(this).clone().removeClass('cropper-hidden');

			                $clone.css({
			                  display: 'block',
			                  width: '100%',
			                  minWidth: 0,
			                  minHeight: 0,
			                  maxWidth: 'none',
			                  maxHeight: 'none'
			                });

			                $previews.css({
			                  width: '100%',
			                  overflow: 'hidden'
			                }).html($clone);
						},

						crop: function (e) {
		                	var imageData = $(this).cropper('getImageData');
		                	var previewAspectRatio = e.width / e.height;

		                	$previews.each(function () {
			                  var $preview = $(this);
			                  var previewWidth = $preview.width();
			                  var previewHeight = previewWidth / previewAspectRatio;
			                  var imageScaledRatio = e.width / previewWidth;
	
			                  $preview.height(previewHeight).find('img').css({
			                    width: imageData.naturalWidth / imageScaledRatio,
			                    height: imageData.naturalHeight / imageScaledRatio,
			                    marginLeft: -e.x / imageScaledRatio,
			                    marginTop: -e.y / imageScaledRatio
			                  });
							});
		              }
			    	});
				}
			},
			error: function(err) {}
		});
		
    	if (window.FileReader) {//选择图片
            $inputImage.change(function () {
                var fileReader = new FileReader(),
                    files = this.files,
                    file;

                if (!files.length) {
                    return;
                }
                file = files[0];
                if (/^image\/\w+$/.test(file.type)) {
                    fileReader.readAsDataURL(file);
                    fileReader.onload = function () {
                        $image.cropper("reset", true).cropper("replace", this.result);
                        $inputImage.val("");
                    };
                } else {
                    showMessage("请选择图片.");
                }
            });
        } else {
            $inputImage.addClass("hide");
        }
    	$upload.click(function(){
    		$.ajax({
    			url: "api/user/avatar",
    			type: "POST",
    			data: {
    				userId: 1,
    				base64: $image.cropper("getCroppedCanvas").toDataURL()
    			},
    			success: function(data) {
    				if (data.code == 0) {
    					swal('', '修改成功!', 'success');
    				} 
    			},
    			error: function(err) {}
    		});
    	});
	})( jQuery );
	</script>
	
</body>

</html>