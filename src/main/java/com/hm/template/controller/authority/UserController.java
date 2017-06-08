package com.hm.template.controller.authority;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hm.template.common.PathFormat;
import com.hm.template.common.result.Code;
import com.hm.template.common.result.Result;
import com.hm.template.common.result.ResultInfo;
import com.hm.template.common.utils.CiphersUtils;
import com.hm.template.common.utils.CommonUtils;
import com.hm.template.common.utils.CurrentUserUtils;
import com.hm.template.common.utils.FileUtils;
import com.hm.template.entity.authority.UserEntity;
import com.hm.template.service.authority.UserService;

@RestController
public class UserController {

	static Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	UserService userService;

	@Autowired
	HttpServletRequest request;

	@Value("${customize.path.upload}")
	private String filePath;

	@Value("${customize.path.upload.avatar}")
	private String avatarUploadPath;

	/**
	 * 添加用户
	 * 
	 * @param username
	 * @param password
	 * @param mobile
	 * @return
	 */
	@RequestMapping(value = "/api/user/add", method = RequestMethod.POST)
	public Result add(String username, String password, String mobile) {
		try {
			UserEntity user = userService.findByUsername(username);
			if (user != null) {
				return new Result(Code.EXISTED.value(), "user exist");
			}

			Date now = new Date();
			user = new UserEntity(username, CiphersUtils.getInstance().MD5Password(password), mobile, now, now);
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 编辑用户
	 * 
	 * @param userId
	 * @param mobile
	 * @return
	 */
	@RequestMapping(value = "/api/user/edit", method = RequestMethod.POST)
	public Result edit(Long userId, String mobile) {
		try {
			UserEntity user = userService.findOne(userId);
			user.setMobile(mobile);
			user.setUpdateTime(new Date());
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 删除用户
	 * 
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/api/user/delete", method = RequestMethod.GET)
	public Result delete(Long userId) {
		try {
			userService.delete(userId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 批量删除用户
	 * 
	 * @param userIds
	 * @return
	 */
	@RequestMapping(value = "/api/user/deleteBatch", method = RequestMethod.GET)
	public Result deleteBatch(String userIds) {
		try {
			userService.delete(CommonUtils.convent2Long(userIds));
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 用户详情
	 * 
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/api/user/detail", method = RequestMethod.GET)
	public Result detail(Long userId) {
		try {
			UserEntity user = userService.findOne(userId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", user);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}

	}

	/**
	 * 获取用户列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/api/user/list", method = RequestMethod.GET)
	public Result listUser() {
		try {
			List<UserEntity> list = userService.list();
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 用户登录
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "/api/user/login", method = RequestMethod.POST)
	public Result login(String username, String password) {
		try {
			UserEntity user = userService.findByUsername(username);
			if (user == null) {
				return new Result(Code.NULL.value(), "user not exist");
			}

			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(password), user.getPassword())) {
				return new Result(Code.USER_PWD_ERROR.value(), "password error");
			}

			String loginIp = request.getRemoteAddr();
			user.setLastLoginIp(loginIp);
			user.setLastLoginTime(new Date());

			userService.save(user);
			CurrentUserUtils.getInstance().serUser(user);
			return new Result(Code.SUCCESS.value(), "login success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 用户名是否存在
	 * 
	 * @param username
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "/api/user/exist", method = RequestMethod.GET)
	public @ResponseBody String exist(String username) throws JsonProcessingException {
		boolean result = true;

		UserEntity user = userService.findByUsername(username);
		if (user != null) {
			result = false;
		}

		Map<String, Boolean> map = new HashMap<>();
		map.put("valid", result);
		ObjectMapper mapper = new ObjectMapper();
		String resultString = mapper.writeValueAsString(map);

		return resultString;
	}

	/**
	 * 上传头像
	 * 
	 * @param userId
	 * @param text
	 * @return
	 */
	@RequestMapping(value = "/api/user/avatar", method = RequestMethod.POST)
	public Result avatar(Long userId, String base64) {
		try {
			String str = base64.substring(base64.indexOf(",") + 1);
			String avatarPath = avatarUploadPath + ".jpg";

			byte[] bytes = Base64.decodeBase64(new String(str).getBytes());
			ByteArrayInputStream in = new ByteArrayInputStream(bytes);

			avatarPath = PathFormat.parse(avatarPath, "");
			Path relPath = Paths.get(filePath, avatarPath);
			File file = relPath.toFile();
			FileUtils.sureDirExists(file, true);

			FileOutputStream out = new FileOutputStream(file);
			IOUtils.copy(in, out);

			UserEntity user = userService.findOne(userId);
			user.setAvatarPath(avatarPath);
			userService.save(user);

			return new Result(Code.SUCCESS.value(), "ok");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 修改密码
	 * 
	 * @param userId
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
	@RequestMapping(value = "/api/user/password", method = RequestMethod.GET)
	public Result password(Long userId, String oldPassword, String newPassword) {
		try {
			UserEntity user = userService.findOne(userId);
			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(oldPassword), user.getPassword())) {
				return new Result(Code.USER_PWD_ERROR.value(), "password error");
			}

			user.setPassword(CiphersUtils.getInstance().MD5Password(newPassword));
			userService.save(user);
			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
