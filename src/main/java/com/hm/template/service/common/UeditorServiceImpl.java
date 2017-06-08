package com.hm.template.service.common;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hm.template.common.PathFormat;

@Service
public class UeditorServiceImpl implements UeditorService {
	
	static Logger log = LoggerFactory.getLogger(UeditorServiceImpl.class);
	
	@Value("${customize.path.upload.html}")
	private String htmlPath;
	
	@Value("${customize.path.upload}")
	private String filePath;
	
	@Value("${customize.path.upload.image}")
	private String imagePath;
	
	@Override
	public String save(String content) throws IOException {
		String linkPath = htmlPath + ".html";
		linkPath = PathFormat.parse(linkPath, "");
		
		String tarPath = filePath + File.separator + linkPath;
		File file = new File(tarPath);
		FileUtils.write(file, content, "UTF-8");
		
		return linkPath;
	}
	
	@Override
	public String saveImage(MultipartFile uploadImage) throws IOException {
		if (uploadImage == null) {
			return "";
		}
		
		String imageName = uploadImage.getOriginalFilename();
		String suffix = getSuffixByFilename(imageName);
		
		String retPath = imagePath + suffix;
		retPath = PathFormat.parse(retPath, "");
		
		Path relPath = Paths.get(filePath, retPath);
		File file = relPath.toFile();
		com.hm.template.common.utils.FileUtils.sureDirExists(file, true);
		
		BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(file));
		stream.write(uploadImage.getBytes());
		stream.close();
		
		return retPath;
	}
	
	@Override
	public String update(String linkPath, String content) throws IOException {
		String tarPath = filePath + File.separator + linkPath;
		File file = new File(tarPath);
		FileUtils.write(file, content, "UTF-8");
		
		return linkPath;
	}
	
	public static String getSuffixByFilename ( String filename ) {
		return filename.substring( filename.lastIndexOf( "." ) ).toLowerCase();
	}

}