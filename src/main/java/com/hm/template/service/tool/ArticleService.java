package com.hm.template.service.tool;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hm.template.entity.tool.ArticleEntity;

public interface ArticleService {
	
	ArticleEntity findOne(Long articleId);
	
	void save(ArticleEntity article);
	
	void delete(Long articleId);
	
	void delete(List<Long> articleIds);
	
	List<ArticleEntity> list();
	
	Page<ArticleEntity> listPaging(int page, int size);

}
