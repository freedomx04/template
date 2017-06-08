package com.hm.template.controller.weixin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hm.template.common.result.Code;
import com.hm.template.common.result.Result;
import com.hm.template.common.result.ResultInfo;
import com.hm.template.common.weixin.WxUtil;

@RestController
public class WeixinCommonController {
	
	static Logger log = LoggerFactory.getLogger(WeixinCommonController.class);
	
	@RequestMapping(value = "/api/weixin/getUserId", method = RequestMethod.GET)
	public Result getUserId(String code) {
		try {
			String token = WxUtil.getInstace().getToken();
			String userId = WxUtil.getUserId(token, code);
			return new ResultInfo(Code.SUCCESS.value(), "ok", userId);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
