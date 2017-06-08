package com.hm.template.entity.authority;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.hm.template.entity.BaseEntity;

@Entity
@Table(name = "authority_user")
public class UserEntity extends BaseEntity {
	
	/**
	 * 用户状态 0：有效   1：无效
	 */
	public class UserStatus {
		public static final int STATUS_VALID = 0;
		public static final int STATUS_NO_VALID = 1;
	}
	
	/**
	 * 性别 1:男   2：女 
	 */
	public class Gender {
		public static final int GENDER_MALE = 1;
		public static final int GENDER_FEMALE = 2;
	}
	
	/**
	 * 用户名，唯一
	 */
	@Column(unique = true)
	private String username;	
	
	/**
	 * MD5加密后的密码
	 */
	private String password;	
	
	/**
	 * 手机号码,唯一
	 */
	@Column(unique = true)
	private String mobile;	
	
	/**
	 * 邮箱,唯一
	 */
	@Column(unique = true)
	private String email;
	
	/**
	 * 性别,1表示男性  2表示女性
	 */
	private Integer gender = Gender.GENDER_MALE;
	
	/**
	 * 头像地址
	 */
	private String avatarPath;
	
	/**
	 * 用户状态,0表示启用 1表示禁用
	 */
	private Integer status = UserStatus.STATUS_VALID;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 上传登录Ip
	 */
	private String lastLoginIp;
	
	/**
	 * 上次登录时间
	 */
	private Date lastLoginTime;
	
	
	public UserEntity() {
		// TODO Auto-generated constructor stub
	}

	public UserEntity(String username, String password, String mobile, Date createTime, Date updateTime) {
		super();
		this.username = username;
		this.password = password;
		this.mobile = mobile;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getAvatarPath() {
		return avatarPath;
	}

	public void setAvatarPath(String avatarPath) {
		this.avatarPath = avatarPath;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getLastLoginIp() {
		return lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

}