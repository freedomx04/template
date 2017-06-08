package com.hm.template.repository.authority;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.hm.template.entity.authority.UserEntity;

public interface UserRepository extends CrudRepository<UserEntity, Long> {
	
	UserEntity findByUsername(String username);
	
	Iterable<UserEntity> findByIdIn(List<Long> userIds);
	
}
