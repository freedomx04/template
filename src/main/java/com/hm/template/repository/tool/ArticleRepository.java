package com.hm.template.repository.tool;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hm.template.entity.tool.ArticleEntity;

public interface ArticleRepository extends PagingAndSortingRepository<ArticleEntity, Long> {
	
	Iterable<ArticleEntity> findByIdIn(List<Long> articleIds);
	
	List<ArticleEntity> findAllByOrderByUpdateTimeDesc();
	
	Page<ArticleEntity> findAllByOrderByUpdateTimeDesc(Pageable pageable);
	
}
