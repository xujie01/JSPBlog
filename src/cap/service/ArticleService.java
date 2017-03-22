package cap.service;

import java.util.List;

import cap.bean.Article;
import cap.bean.User;
import cap.util.PageControl;

public interface ArticleService {

	/**
	 * 添加文章
	 */
	public abstract int insertArtical(String title, int userId, int scgId,
			int cgId, String content, String summary);

	/**
	 * 用于文章的分页
	 * @param curPageStr
	 * @return
	 */
	public abstract PageControl getData(String curPageStr);
	public abstract PageControl getFilterData(String curPageStr,String sysCategoryId);

	/**	
	 * 根据用户分页显示数据
	 */
	public abstract PageControl getByPageUserId(String curPageStr, int userId);
	public abstract PageControl getByPageUserCategoryId(String curPageStr, int userId,int categoryId);

	public abstract List<Article> search(String q);

	public abstract int deleteArtical(int artId);

	public abstract int UpdateArtical(int artId, String title, int userId,
			int scgId, int cgId, String content, String summary);

	public abstract List<Article> getBycgIdorscgId(int cgId, int scgId,
			int artId);

	public abstract List<Article> topTenArticle();

	public abstract List<User> getActiveUser(int num);

	public abstract Article getById(int id);
	
	public int updateCount(int artId);
	
	public abstract List<Article> getAllArtical();

}