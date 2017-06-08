package com.hm.template.entity.weixin;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.hm.template.entity.BaseEntity;

@Entity
@Table(name = "weixin_memo")
public class MemoEntity extends BaseEntity {
	
	/**
	 * 微信UserId
	 */
	private String userId;
	
	/**
	 * 备忘录内容
	 */
	private String content;
	
	public MemoEntity() {
		// TODO Auto-generated constructor stub
	}

	public MemoEntity(String userId, String content, Date createTime, Date updateTime) {
		this.userId = userId;
		this.content = content;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}
