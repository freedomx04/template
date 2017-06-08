package com.hm.template.controller.weixin;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hm.template.common.result.Code;
import com.hm.template.common.result.Result;
import com.hm.template.common.result.ResultInfo;
import com.hm.template.entity.weixin.MemoEntity;
import com.hm.template.service.weixin.MemoService;

@RestController
public class MemoController {
	
	static Logger log = LoggerFactory.getLogger(MemoController.class);
	
	@Autowired
	MemoService memoService;
	
	/**
	 * 创建备忘录
	 * @param userId
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/api/weixin/memo/create", method = RequestMethod.POST)
	public Result create(String userId, String content) {
		try {
			Date now = new Date();
			MemoEntity memo = new MemoEntity(userId, content, now, now);
			memoService.save(memo);
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	/**
	 * 更新备忘录
	 * @param memoId
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/api/weixin/memo/update", method = RequestMethod.POST)
	public Result update(Long memoId, String content) {
		try {
			MemoEntity memo = memoService.findOne(memoId);
			memo.setContent(content);
			memo.setUpdateTime(new Date());
			memoService.save(memo);
			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	/**
	 * 删除备忘录
	 * @param memoId
	 * @return
	 */
	@RequestMapping(value = "/api/weixin/memo/delete", method = RequestMethod.GET)
	public Result delete(Long memoId) {
		try {
			memoService.delete(memoId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	/**
	 * 批量删除备忘录
	 * @param memoIdList
	 * @return
	 */
	@RequestMapping(value = "/api/weixin/memo/batchDelete", method = RequestMethod.GET)
	public Result batchDelete(@RequestParam("memoIdList[]") List<Long> memoIdList) {
		try {
			memoService.delete(memoIdList);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	/**
	 * 读取备忘录
	 * @param memoId
	 * @return
	 */
	@RequestMapping(value = "/api/weixin/memo/get", method = RequestMethod.GET)
	public Result get(Long memoId) {
		try {
			MemoEntity memo = memoService.findOne(memoId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", memo);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	/**
	 * 获取用户备忘录列表
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "api/weixin/memo/list", method = RequestMethod.GET)
	public Result list(String userId) {
		try {
			List<MemoEntity> memoList = memoService.listByUserId(userId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", memoList);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
}
