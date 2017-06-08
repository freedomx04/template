package com.hm.template.repository.weixin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.hm.template.entity.weixin.MemoEntity;

public interface MemoRepository extends PagingAndSortingRepository<MemoEntity, Long> {
	
	List<MemoEntity> findByUserId(String userId);
	
	Page<MemoEntity> findByUserId(String userId, Pageable pageable);
	
}
