<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>H+ 后台主题UI框架 - 高级表单</title>
    <meta name="keywords" content="H+后台主题,后台bootstrap框架,会员中心主题,后台HTML,响应式后台">
    <meta name="description" content="H+是一个完全响应式，基于Bootstrap3最新版本开发的扁平化主题，她采用了主流的左右两栏式布局，使用了Html5+CSS3等现代技术">

    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="${ctx}/plugins/cropper/cropper.min.css" rel="stylesheet">
    <link href="${ctx}/plugins/animate/animate.min.css" rel="stylesheet">
    <link href="${ctx}/plugins/hplus/style.min.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title  back-change">
                        <h5>图片裁剪 <small>http://fengyuanchen.github.io/cropper/</small></h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项 01</a>
                                </li>
                                <li><a href="#">选项 02</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <p>
                            一款简单的jQuery图片裁剪插件
                        </p>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="image-crop">
                                    <img style="width: 100%; height:auto;" src="img/a3.jpg">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <h4>图片预览：</h4>
                                <div class="img-preview img-preview-sm"></div>
                                <h4>说明：</h4>
                                <p>
                                    你可以选择新图片上传，然后下载裁剪后的图片
                                </p>
                                <div class="btn-group">
                                    <label title="上传图片" for="inputImage" class="btn btn-primary">
                                        <input type="file" accept="image/*" name="file" id="inputImage" class="hide"> 上传新图片
                                    </label>
                                    <label title="下载图片" id="download" class="btn btn-primary">下载</label>
                                </div>
                                <h4>其他说明：</h4>
                                <p>
                                    你可以使用<code>$({image}).cropper(options)</code>来配置插件
                                </p>
                                <div class="btn-group">
                                    <button class="btn btn-white" id="zoomIn" type="button">放大</button>
                                    <button class="btn btn-white" id="zoomOut" type="button">缩小</button>
                                    <button class="btn btn-white" id="rotateLeft" type="button">左旋转</button>
                                    <button class="btn btn-white" id="rotateRight" type="button">右旋转</button>
                                    <button class="btn btn-warning" id="setDrag" type="button">裁剪</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	

    <script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="${ctx}/plugins/cropper/cropper.min.js"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
	<script>
    $(document).ready(function(){
    	var o = $(".image-crop > img");
    	$(o).cropper({
    		aspectRatio: 1,
    		preview:".img-preview",
    		done:function(){}
    	});
    	var r=$("#inputImage");
    	window.FileReader ? r.change(function(){
    		var e,i=new FileReader,t=this.files;
    		t.length&&(e=t[0],/^image\/\w+$/.test(e.type)?(i.readAsDataURL(e),i.onload=function(){r.val(""),o.cropper("reset",!0).cropper("replace",this.result)}):showMessage("请选择图片文件"))
    	}) : r.addClass("hide");
    	$("#download").click(function(){
    		window.open(o.cropper("getCroppedCanvas").toDataURL())
    	});
    	$("#zoomIn").click(function(){
    		o.cropper("zoom",.1)
    	});
    	$("#zoomOut").click(function(){
    		o.cropper("zoom",-.1)
    	});
    	$("#rotateLeft").click(function(){
    		o.cropper("rotate",45)});
    	$("#rotateRight").click(function(){o.cropper("rotate",-45)});
    	$("#setDrag").click(function(){o.cropper("setDragMode","crop")});
    })
    </script>
</body>

</html>