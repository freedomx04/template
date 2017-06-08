package com.hm.template.common.utils;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CommonUtils {
	
	static Logger log = LoggerFactory.getLogger(CommonUtils.class);
	
	/**
	 * 字符串数组转换成长整型数组
	 * @param str
	 * @return
	 */
	public static List<Long> convent2Long(String str) {
		List<Long> list = new LinkedList<Long>();
		for (String idStr: StringUtils.split(str, ",")) {
			list.add(Long.parseLong(idStr));
		}
		return list;
	}

}
