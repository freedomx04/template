package com.hm.template.service.weixin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.hm.template.entity.weixin.MemoEntity;
import com.hm.template.repository.weixin.MemoRepository;

@Service
public class MemoServiceImpl implements MemoService {
	
	@Autowired
	MemoRepository memoRepository;

	@Override
	public MemoEntity findOne(Long memoId) {
		return memoRepository.findOne(memoId);
	}

	@Override
	public void save(MemoEntity memo) {
		memoRepository.save(memo);
	}

	@Override
	public void delete(Long memoId) {
		memoRepository.delete(memoId);
	}
	
	@Override
	public void delete(List<Long> memoIdList) {
		for (Long memoId: memoIdList) {
			memoRepository.delete(memoId);
		}
	}

	@Override
	public List<MemoEntity> listByUserId(String userId) {
		return memoRepository.findByUserId(userId);
	}

	@Override
	public Page<MemoEntity> listByUserId(String userId, int page, int size) {
		return memoRepository.findByUserId(userId, new PageRequest(page, size));
	}

}
