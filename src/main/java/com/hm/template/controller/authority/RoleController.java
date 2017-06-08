package com.hm.template.controller.authority;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hm.template.entity.authority.UserEntity;
import com.hm.template.service.authority.UserService;

@RestController
public class RoleController {
	
	static Logger log = LoggerFactory.getLogger(RoleController.class);
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/api/role/{id}", method = RequestMethod.GET)
	public UserEntity findById(@PathVariable("id") Long id) {
		return userService.findOne(id);
	}

}
