package com.hm.template.controller.utils;

import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.hm.template.common.result.Code;
import com.hm.template.common.result.Result;  
  
/** 
 * ClassName: CaptchaImageCreateController <br/> 
 * Function: 生成验证码Controller. <br/> 
 * date: 2013-12-10 上午11:37:42 <br/> 
 * 
 * @author chenzhou1025@126.com 
 */  
@RestController  
public class CaptchaImageController {  
	static Logger log = LoggerFactory.getLogger(CaptchaImageController.class);
	
    private Producer captchaProducer = null;  
  
    @Autowired
    public void setCaptchaProducer(Producer captchaProducer){  
        this.captchaProducer = captchaProducer;  
    }  
  
    @RequestMapping(value = "/kaptcha.jpg", method = RequestMethod.GET)
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception{  
		response.setDateHeader("Expires", 0);  
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");  
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
		response.setHeader("Pragma", "no-cache");  
		response.setContentType("image/jpeg");  
		
        // create the text for the image  
        String capText = captchaProducer.createText();  
  
        // store the text in the session  
        request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);  
  
        // create the image with the text  
        BufferedImage bi = captchaProducer.createImage(capText);  
        ServletOutputStream out = response.getOutputStream();  
  
        // write the data out  
        ImageIO.write(bi, "jpg", out);  
        try {  
            out.flush();  
        } finally {  
            out.close();  
        }  
        return null;  
    }  
    
    @RequestMapping(value = "/check", method = RequestMethod.POST)  
    @ResponseBody  
    public Result loginCheck(HttpServletRequest request, @RequestParam(value = "kaptcha") String kaptchaReceived){  
        //用户输入的验证码的值  
        String kaptchaExpected = (String) request.getSession().getAttribute(  
                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
        //校验验证码是否正确  
        if (kaptchaReceived == null || !kaptchaReceived.equals(kaptchaExpected)) { 
			return new Result(Code.ERROR.value(), "");//返回验证码错误  
        }  
        return new Result(Code.SUCCESS.value(), "checked_success"); //校验通过返回成功  
    }  
}  