package com.hm.template.service.weixin;

import java.util.List;

import org.springframework.data.domain.Page;

import com.hm.template.entity.weixin.MemoEntity;

public interface MemoService {
	
	MemoEntity findOne(Long memoId);
	
	void save(MemoEntity memo);
	
	void delete(Long memoId);
	
	void delete(List<Long> memoIdList);
	
	List<MemoEntity> listByUserId(String userId);
	
	Page<MemoEntity> listByUserId(String userId, int page, int size);

}
