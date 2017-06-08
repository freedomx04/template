package com.hm.template.controller.tool;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hm.template.common.result.Code;
import com.hm.template.common.result.Result;
import com.hm.template.common.result.ResultInfo;
import com.hm.template.common.utils.CommonUtils;
import com.hm.template.entity.tool.ArticleEntity;
import com.hm.template.service.common.UeditorService;
import com.hm.template.service.tool.ArticleService;

@RestController
public class ArticleController {

	static Logger log = LoggerFactory.getLogger(ArticleController.class);

	@Autowired
	ArticleService articleService;

	@Autowired
	UeditorService ueditorService;

	@Value("${customize.path.upload}")
	private String filePath;

	/**
	 * 新增文章
	 * 
	 * @param title
	 * @param source
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/api/article/add", method = RequestMethod.POST)
	public Result add(String title, String source, String content) {
		try {
			String linkPath = ueditorService.save(content);

			Date now = new Date();
			ArticleEntity article = new ArticleEntity(title, source, linkPath, "", null, now, now);
			articleService.save(article);

			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 编辑文章
	 * 
	 * @param articleId
	 * @param title
	 * @param source
	 * @param content
	 * @return
	 */
	@RequestMapping(value = "/api/article/edit", method = RequestMethod.POST)
	public Result edit(Long articleId, String title, String source, String content) {
		try {
			ArticleEntity article = articleService.findOne(articleId);

			article.setTitle(title);
			article.setSource(source);
			String linkPath = ueditorService.update(article.getLinkPath(), content);
			article.setLinkPath(linkPath);
			article.setUpdateTime(new Date());
			articleService.save(article);

			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 删除文章
	 * 
	 * @param articleId
	 * @return
	 */
	@RequestMapping(value = "/api/article/delete", method = RequestMethod.GET)
	public Result delete(Long articleId) {
		try {
			articleService.delete(articleId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 批量删除文章
	 * 
	 * @param articleIds
	 * @return
	 */
	@RequestMapping(value = "/api/article/deleteBatch", method = RequestMethod.GET)
	public Result deleteBatch(String articleIds) {
		try {
			articleService.delete(CommonUtils.convent2Long(articleIds));
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 文章详情
	 * 
	 * @param articleId
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/api/article/detail", method = RequestMethod.GET)
	public Result detail(Long articleId) throws IOException {
		try {
			ArticleEntity article = articleService.findOne(articleId);
			File file = new File(filePath + File.separator + article.getLinkPath());
			String content = FileUtils.readFileToString(file, "UTF-8");
			article.setContent(content);
			return new ResultInfo(Code.SUCCESS.value(), "ok", article);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 获取文章列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/api/article/list", method = RequestMethod.GET)
	public Result list() {
		try {
			List<ArticleEntity> list = articleService.list();
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	/**
	 * 获取文章列表（分页）
	 * 
	 * @param page
	 * @param size
	 * @return
	 */
	@RequestMapping(value = "/api/article/listPaging", method = RequestMethod.GET)
	public Result listPaging(int page, int size) {
		try {
			Page<ArticleEntity> ret = articleService.listPaging(page, size);
			return new ResultInfo(Code.SUCCESS.value(), "ok", ret);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
