package cap.dao;

import java.util.List;

import cap.bean.Article;
import cap.bean.User;

public interface ArticleDao {

	/**
	 * 获取站点指定数目的活跃用户
	 * 
	 * return 用户信息：用户列表，
	 */
	public abstract List<User> getActiveUser(int num);

	/**
	 * 跟userId获取所有文章
	 */
	public abstract List<Article> getByUserId(int userId);

	/**
	 * 根据id获取文章
	 */
	public abstract Article getById(int id);

	/**
	 * 新增一篇文章
	 * 
	 * return 影响行数
	 */
	public abstract int insertArticle(String title, int userId, int scgId,
			int cgId, String content, String summary);

	/**
	 * 更新文章
	 * 
	 * return 影响行数
	 */
	public abstract int updateArticle(int artId, String title, int userId,
			int scgId, int cgId, String content, String summary);

	/**
	 * 删除文章，把is_delete字段置为1
	 * 
	 * return 影响行数
	 */
	public abstract int deleteArtical(int artId);

	/**
	 * 获取当前所有未被逻辑删除的文章
	 */
	public abstract List<Article> getAllArtical();

	/**
	 * 搜索文章
	 */
	public abstract List<Article> search(String q);

	public abstract List<Article> getArticleByPage(int curPage, int size);
	public abstract List<Article> getFilterArticleByPage(int curPage, int size,String sysCategoryId);

	public abstract List<Article> getArticleByPageUserId(int curPage, int size,int userId);
	public abstract List<Article> getArticleByPageUserCategoryId(int curPage, int size,int userId,int categoryId);

	public abstract List<Article> getBycgIdorscgId(int cgId, int scgId,
			int artId);

	/**
	 * 查询点击率前10的文章
	 * @return
	 */
	public abstract List<Article> topTenArticle();
	
	/**
	 * 文章点击率+1
	 * @param artId
	 * @return
	 */
	public int updateCount(int artId);

	

}