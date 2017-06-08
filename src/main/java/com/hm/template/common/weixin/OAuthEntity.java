package com.hm.template.common.weixin;

public class OAuthEntity {

	/**
	 * 成员UserID
	 */
	private String UserId;

	/**
	 * 非企业成员的标识，对当前企业号唯一
	 */
	private String OpenId;

	/**
	 * 手机设备号(由微信在安装时随机生成，删除重装会改变，升级不受影响，同一设备上不同的登录账号生成的deviceid也不同)
	 */
	private String DeviceId;

	public OAuthEntity() {
		// TODO Auto-generated constructor stub
	}

	public String getUserId() {
		return UserId;
	}

	public void setUserId(String userId) {
		UserId = userId;
	}

	public String getOpenId() {
		return OpenId;
	}

	public void setOpenId(String openId) {
		OpenId = openId;
	}

	public String getDeviceId() {
		return DeviceId;
	}

	public void setDeviceId(String deviceId) {
		DeviceId = deviceId;
	}

}
