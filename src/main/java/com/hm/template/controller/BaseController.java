package com.hm.template.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BaseController {

	static Logger log = LoggerFactory.getLogger(BaseController.class);

	@RequestMapping(value = { "/", "/index" })
	String index() {
		return "index";
	}
	
	@RequestMapping(value = "home")
	String home() {
		return "home";
	}
	
	/**
	 * 登录,注册,找回密码
	 */
	@RequestMapping(value = "login")
	String login() {
		return "pages/login";
	}
	
	@RequestMapping(value = "register")
	String register() {
		return "pages/register";
	}
	
	
	/**
	 * 权限管理菜单接口
	 */
	@RequestMapping(value = "user")
	String user() {
		return "pages/authority/user";
	}
	
	
	@RequestMapping(value = "overview")
	String overview() {
		return "overview";
	}

	@RequestMapping(value = "role")
	String role() {
		return "role";
	}
	
	@RequestMapping(value = "visit")
	String visit() {
		return "visit";
	}
	
	/**
	 * 工具
	 */
	
	@RequestMapping(value = "articleList")
	String articleList() {
		return "pages/tool/articleList";
	}
	
	@RequestMapping(value = "article")
	String article() {
		return "pages/tool/article";
	}
	
	@RequestMapping(value = "articleDetail")
	String articleDetail() {
		return "pages/tool/articleDetail";
	}
	
	
	/**
	 * 个人中心
	 * 
	 */
	@RequestMapping(value = "avatar")
	String avatar() {
		return "pages/personal/avatar";
	}
	
	@RequestMapping(value = "modifyPassword")
	String modifyPassword() {
		return "pages/personal/modifyPassword";
	}
	
	@RequestMapping(value = "cropper")
	String cropper() {
		return "pages/utils/cropper";
	}
	
	@RequestMapping(value = "kaptcha")
	String kaptcha() {
		return "pages/utils/kaptcha";
	}
	
}
