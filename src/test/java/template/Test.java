package template;

import com.hm.template.common.utils.HttpUtils;

public class Test {

	public static void main(String[] args) throws Exception {
		Test test = new Test();
		test.execute();
	}

	public void execute() throws Exception {
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxbf8123324000bd42&redirect_uri=http%3a%2f%2fwww.0791soft.com%2f&response_type=code&scope=snsapi_userinfo#wechat_redirect";
	
		String aa = HttpUtils.getResponseAsString(url);
		System.out.println(aa);
	
	}


}
