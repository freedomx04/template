package com.hm.template.entity.tool;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.hm.template.entity.BaseEntity;
import com.hm.template.entity.authority.UserEntity;

@Entity
@Table(name = "tool_article", indexes = { 
	@Index(name = "index_tool_article_updateTime", columnList = "updateTime"),	
})
public class ArticleEntity extends BaseEntity {
	
	/**
	 * 文章标题
	 */
	private String title;
	
	/**
	 * 文章来源
	 */
	private String source;
	
	/**
	 * 文章路径
	 */
	private String linkPath;
	
	/**
	 * 文章内容
	 */
	private String content;
	
	/**
	 * 图片路径
	 */
	private String imagePath;
	
	/**
	 * 发布人
	 */
	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "user_id")
	private UserEntity user;
	
	public ArticleEntity() {
		super();
	}
	
	public ArticleEntity(String title, String source, String linkPath, String imagePath, UserEntity user, Date createTime, Date updateTime) {
		super();
		this.title = title;
		this.source = source;
		this.linkPath = linkPath;
		this.imagePath = imagePath;
		this.user = user;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getLinkPath() {
		return linkPath;
	}

	public void setLinkPath(String linkPath) {
		this.linkPath = linkPath;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}
	
}