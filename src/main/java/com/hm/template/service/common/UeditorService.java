package com.hm.template.service.common;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public interface UeditorService {
	
	String save(String content) throws IOException;
	
	String saveImage(MultipartFile uploadImage) throws IOException;
	
	String update(String linkPath, String content) throws IOException;

}
