package com.hm.template.common.result;

public enum Code {
	
	SUCCESS(0),				// 操作成功
	
	// 操作相关
	ERROR(1001),			// 操作失败
	NULL(1002),				// 数据为空
	EXISTED(1003),			// 数据库已存在
	CONSTRAINT(1004),		// 数据库有关联
	
	// 用户相关
	USER_PWD_ERROR(2001),	// 密码错误
	
	
	;
	
	
	private final int value;
	
	private Code(int value) {
		this.value = value;
	}
	
	public int value() {
		return this.value;
	}

}
