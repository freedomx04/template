package com.hm.template.common.weixin;

public class TokenEntity {

	/**
	 * 获取到的凭证。长度为64至512个字节
	 */
	private String access_token;

	/**
	 * 凭证的有效时间（秒）
	 */
	private long expires_in;

	public TokenEntity() {
		// TODO Auto-generated constructor stub
	}

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public long getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(long expires_in) {
		this.expires_in = expires_in;
	}

}
