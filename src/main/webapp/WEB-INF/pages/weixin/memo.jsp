<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
	
	<title>备忘录</title>

	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/weixin/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/weixin/example.css">

	<style type="text/css">
		@media(min-width: 768px) {
			.weixin-memo > div {
				width: 375px;
				height: 667px;
				margin: 20px auto;
				overflow: auto;
				border: 1px solid #ddd;
			}
		}
	</style>

</head>

<body class="weixin-bg weixin-memo">

	<div>
	
		<div class="weui-cells__title"></div>
		<div class="weui-cells weui-cells_form">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <textarea class="weui-textarea" placeholder="请输入文本" rows="5" id="textarea-memo"></textarea>
                </div>
            </div>
        </div>
	
 		<div class="weui-btn-area">
            <a href="javascript:" class="weui-btn weui-btn_primary" id="btn-memo-add">提交</a>
        </div>
	</div>
	
	
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
	<script type="text/javascript" src="https://res.wx.qq.com/open/libs/weuijs/1.0.0/weui.min.js"></script>
	
	<script type="text/javascript">
	;(function( $ ) {
		
		var $page = $('.weixin-memo');
		//var userId = '${userId}';
		var userId = 'sunyiyun';
		
		if (userId == '') {
			document.head.innerHTML = '<title>抱歉，出错了</title><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0"><link rel="stylesheet" type="text/css" href="https://res.wx.qq.com/open/libs/weui/0.4.1/weui.css">';
            document.body.innerHTML = '<div class="weui_msg"><div class="weui_icon_area"><i class="weui_icon_info weui_icon_msg"></i></div><div class="weui_text_area"><h4 class="weui_msg_title">获取授权失败</h4></div></div>';
			return;			
		}
		
		wx.config({
		    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		    appId: '${appId}', 			// 必填，企业微信的cropID
		    timestamp: ${timestamp}, 	// 必填，生成签名的时间戳
		    nonceStr: '${nonceStr}', 	// 必填，生成签名的随机串
		    signature: '${signature}',	// 必填，签名，见附录1
		    jsApiList: [
		        'checkJsApi',
		        'chooseImage',
		        'getNetworkType',
		        'onMenuShareAppMessage',
		        'openLocation'
		    ] 	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		
		wx.ready(function(){
			// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，
			// 则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中
			
		});
		
		wx.error(function(res){
		    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
		});
		
		$page
		.on('click', '#btn-memo-add', function(){
			$.ajax({
				url: '${ctx}/api/weixin/memo/create',
				type: 'POST',
				data: {
					userId: userId,
					content: $page.find('#textarea-memo').text()
				},
				success: function(ret) {
					if (ret.code == 0) {
						alert('ok');
					}
				},
				error: function(err) {}
			});
		});
		
	})( jQuery );
	</script>

</body>

</html>