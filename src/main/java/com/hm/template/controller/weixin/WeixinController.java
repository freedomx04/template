package com.hm.template.controller.weixin;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.template.common.weixin.WxUtil;

@Controller
public class WeixinController {

	static Logger log = LoggerFactory.getLogger(WeixinController.class);

	@Autowired
	HttpServletRequest request;

	@RequestMapping(value = "weixin/memo")
	String memo(ModelMap modelMap, String code) {
		// 通过微信传过来的code获取授权用户的userId
		String userId = WxUtil.getUserId(code);
		modelMap.addAttribute("userId", userId);
		
		// 页面完整的url(请在当前页面alert(location.href.split(‘#’)[0])确认)，包括’http(s)://‘部分，以及’？’后面的GET参数部分,但不包括’#’hash后面的部分
		String url = request.getRequestURL().toString() + "?" + request.getQueryString();
		
		WxUtil.config(modelMap, url);

		return "pages/weixin/memo";
	}

}