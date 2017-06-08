package com.hm.template.service.tool;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hm.template.entity.tool.ArticleEntity;
import com.hm.template.repository.tool.ArticleRepository;

@Service
public class ArticleServiceImpl implements ArticleService {
	
	@Autowired
	ArticleRepository articleRepository;

	@Override
	public ArticleEntity findOne(Long articleId) {
		return articleRepository.findOne(articleId);
	}

	@Override
	public void save(ArticleEntity article) {
		articleRepository.save(article);
	}
	
	@Override
	public void delete(Long articleId) {
		articleRepository.delete(articleId);
	}

	@Override
	public void delete(List<Long> articleIds) {
		Iterable<ArticleEntity> it = articleRepository.findByIdIn(articleIds);
		articleRepository.delete(it);
	}

	@Override
	public List<ArticleEntity> list() {
		return (List<ArticleEntity>) articleRepository.findAllByOrderByUpdateTimeDesc();
	}

	@Override
	public Page<ArticleEntity> listPaging(int page, int size) {
		return articleRepository.findAllByOrderByUpdateTimeDesc(new PageRequest(page, size));
	}

}