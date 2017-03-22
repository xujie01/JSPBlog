package cap.service.impl;
import java.util.List;

import cap.bean.Article;
import cap.bean.User;
import cap.dao.ArticleDao;
import cap.dao.impl.ArticleDaoImpl;
import cap.service.ArticleService;
import cap.util.PageControl;

public class ArticleServiceImpl implements ArticleService {
	private ArticleDao artDao;

	public ArticleServiceImpl() {
		artDao=new ArticleDaoImpl();
	}
	/*
	 * 添加文章
	 */	
	@Override
	public int insertArtical(String title, int userId, int scgId, 
			int cgId, String content, String summary){
		return artDao.insertArticle(title, userId, scgId, cgId, content, summary);
	}
	
	@Override
	public PageControl getData(String curPageStr){
		int count=artDao.getAllArtical().size();
		PageControl pc = new PageControl(curPageStr, count);
		List<Article> artList= artDao.getArticleByPage(pc.getCurPage(), pc.getPageSize());
		pc.setList(artList);
		return pc;
	}
	@Override
	public PageControl getFilterData(String curPageStr,String sysCategoryId){
		int count=artDao.getAllArtical().size();
		PageControl pc = new PageControl(curPageStr, count);
		List<Article> artList= artDao.getFilterArticleByPage(pc.getCurPage(), pc.getPageSize(),sysCategoryId);
		pc.setList(artList);
		return pc;
	}
	
	/*	
	 * 根据用户分页显示数据
	 */		
	@Override
	public PageControl getByPageUserId(String curPageStr,int userId){
		PageControl pc = new PageControl(curPageStr, artDao.getByUserId(userId).size());
		List<Article> artList=artDao.getArticleByPageUserId(pc.getCurPage(), pc.getPageSize(), userId);
		pc.setList(artList);
		return pc;
	}
	@Override
	public PageControl getByPageUserCategoryId(String curPageStr,int userId,int categoryId){
		PageControl pc = new PageControl(curPageStr, artDao.getByUserId(userId).size());
		List<Article> artList=artDao.getArticleByPageUserCategoryId(pc.getCurPage(), pc.getPageSize(), userId,categoryId);
		pc.setList(artList);
		return pc;
	}
	
	//搜索站内文章
	@Override
	public List<Article> search(String q){
		return artDao.search(q);
	}
	
	//删除博文
	@Override
	public int deleteArtical(int artId){
		return artDao.deleteArtical(artId);
	}
	
	//保存修改博文
	@Override
	public int UpdateArtical(int artId, String title, int userId, 
			int scgId, int cgId, String content, String summary) {
		return artDao.updateArticle(artId, title, userId, scgId, cgId, content, summary);
	}
	
	@Override
	public List<Article> getBycgIdorscgId(int cgId, int scgId, int artId){
		return artDao.getBycgIdorscgId(cgId, scgId, artId);
	}
	
	@Override
	public List<Article> topTenArticle(){
		return artDao.topTenArticle();
	}
	
	@Override
	public List<User> getActiveUser(int num){
		return artDao.getActiveUser(num);
	}
	
	@Override
	public Article getById(int id) {
		return  artDao.getById(id);
	}
	
	@Override
	public int updateCount(int artId) {
		// TODO Auto-generated method stub
		return artDao.updateCount(artId);
	}

	//获取所有文章
	@Override
	public List<Article> getAllArtical() {
		// TODO Auto-generated method stub
		return artDao.getAllArtical();
	}
}
