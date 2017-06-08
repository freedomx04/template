package com.hm.template.common.weixin;

public class TicketEntity extends WxResult {
	
	/**
	 * jsapi_ticke
	 */
	private String ticket;
	
	/**
	 * 凭证的有效时间（秒）
	 */
	private String expires_in;
	
	public TicketEntity() {
		// TODO Auto-generated constructor stub
	}

	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	public String getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(String expires_in) {
		this.expires_in = expires_in;
	}
	
}
