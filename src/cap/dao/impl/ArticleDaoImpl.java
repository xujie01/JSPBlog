package cap.dao.impl;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cap.bean.Article;
import cap.bean.User;
import cap.dao.ArticleDao;
import cap.dao.UserDao;
import cap.db.DBPool;

public class ArticleDaoImpl implements ArticleDao {
	
	@Override
	public List<User> getActiveUser(int num) {
		UserDao userDao = new UserDaoImpl();
		User u = null;
		List<User> uList = null;
		ResultSet rs = null;
		DBPool dbc=new DBPool();
		try {
			uList = userDao.getAllUser();			
			if (num <= uList.size()) {
				uList = new ArrayList<User>();
				String sql="select rownum num,t.* from(select user_id, COUNT(user_id) from article group by user_id order by COUNT(user_id) DESC) t where rownum<= ?";				
				rs = dbc.doQueryRS(sql, new Object[]{num});
				while (rs.next()) {
					//根据从user表根据id查询
					u = userDao.getUserById(rs.getInt("user_id"));
					uList.add(u);					
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return uList;
	}
	
	
	@Override
	public List<Article> getByUserId(int userId) {
		
		DBPool dbc=new DBPool();
		ResultSet rs = null;
		List<Article> artList = null;
		
		try {
			artList = new ArrayList<Article>();
			String sql="select * from article where user_id=? order by publish_time DESC";
			rs=dbc.doQueryRS(sql, new Object[]{userId});
			while (rs.next()) {
				Article art = new Article();
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));				
				artList.add(art);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return artList;
	}
	
	//根据ID获取博文详情
	@Override
	public Article getById(int id) {
		ResultSet rs = null;
		Article art = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select * from article where id=?";
			art = new Article();

			rs=dbc.doQueryRS(sql, new Object[]{id});
			while (rs.next()) {
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			dbc.close();
		}
		
		return art;
	}

	//添加文章
	@Override
	public int insertArticle(String title, int userId, int scgId, int cgId, String content, String summary) {
		int res = -1;
		DBPool dbc=new DBPool();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        Date date = new Date();
	        String nowTime=sdf.format(date);
			String sql="insert into article (user_id,sys_category_id,category_id,title,content,summary,publish_time,is_top,is_delete) values(?, ?, ?, ?, ?, ?,to_date(?, 'yyyy-mm-dd hh24:mi:ss'), 0, 0)";

			res=dbc.doUpdate(sql, new Object[]{userId,scgId,cgId,title,content,summary,nowTime});			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}
	
	//保存修改博文
	@Override
	public int updateArticle(int artId, String title, int userId, int scgId, int cgId, String content, String summary) {
		DBPool dbc=new DBPool();
		int res = -1;		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        Date date = new Date();
	        String nowTime=sdf.format(date);
			String sql="update article " +
							"set title=?, user_id=?, sys_category_id=?, category_id=?, content=?, summary=?, publish_time=to_date(?, 'yyyy-mm-dd hh24:mi:ss'), is_top=0, is_delete=0" +
							" where id=?";
			res=dbc.doUpdate(sql, new Object[]{title,userId,scgId,cgId,content,summary,nowTime,artId});
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}		
		return res;
	}
	
	//删除博文
	@Override
	public int deleteArtical(int artId) {
		DBPool dbc=new DBPool();
		int res = -1;
		
		try {
			String sql="update article set is_delete=1 where id=?";		
			res=dbc.doUpdate(sql, new Object[]{artId});
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			dbc.close();
		}
		
		return res;
	}
	
	//获取所有文章
	@Override
	public List<Article> getAllArtical() {
		ResultSet rs = null;
		List<Article> artList = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select * from article where is_delete=0 order by publish_time DESC";
			artList = new ArrayList<Article>();
			rs=dbc.doQueryRS(sql, new Object[]{});			
			while (rs.next()) {
				Article art = new Article();				
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));				
				artList.add(art);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			dbc.close();
		}
		
		return artList;
	}
	
	//搜索站内文章
	@Override
	public List<Article> search(String q) {
		List<Article> artList = null;

		ResultSet rs = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select * from article where title like ? or content like ? or summary like ? order by publish_time DESC";
			artList = new ArrayList<Article>();		
			q = '%' + q + '%';	
			rs=dbc.doQueryRS(sql,  new Object[]{q,q,q});
			while (rs.next()) {
				Article art = new Article();
				
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				
				artList.add(art);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return artList;
	}
	
	@Override
	public List<Article> getArticleByPage(int curPage, int size) {
		ResultSet rs = null;
		List<Article> artList = null;
		int start = (curPage - 1) * size;	//limit从0开始
		DBPool dbc=new DBPool();
		try {
			String sql="select * from(select rownum num,t.* from(select a.*,u.username from article a, muser u  where u.id=a.user_id and a. is_delete=0 order by publish_time DESC) t where rownum<= ?) where num>= ?";
			artList = new ArrayList<Article>();			
			rs=dbc.doQueryRS(sql, new Object[]{start+size,start});			
			while (rs.next()) {
				Article art = new Article();				
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));
				try {
					art.setUsername(rs.getString("username"));					
				} catch (Exception e) {
					art.setUsername("");					
				}
				artList.add(art);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			dbc.close();
		}
		
		return artList;
	}
	@Override
	public List<Article> getFilterArticleByPage(int curPage, int size,String sysCategoryId) {
		ResultSet rs = null;
		List<Article> artList = null;
		int start = (curPage - 1) * size;	//limit从0开始
		DBPool dbc=new DBPool();
		try {
			String sql="select * from(select rownum num,t.* from(select a.*,u.username from article a, muser u  where u.id=a.user_id and a.sys_category_id = ? and a. is_delete=0 order by publish_time DESC) t where rownum<= ?) where num>= ?";
			artList = new ArrayList<Article>();			
			rs=dbc.doQueryRS(sql, new Object[]{sysCategoryId,start+size,start});			
			while (rs.next()) {
				Article art = new Article();				
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));
				try {
					art.setUsername(rs.getString("username"));					
				} catch (Exception e) {
					art.setUsername("");					
				}
				artList.add(art);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			dbc.close();
		}
		
		return artList;
	}

	@Override
	public List<Article> getArticleByPageUserId(int curPage, int size, int userId) {
		ResultSet rs = null;
		List<Article> artList = null;
		int start = (curPage - 1) * size;	//limit从0开始
		DBPool dbc=new DBPool();
		try {
			String sql="select * from(select rownum num,t.* from(SELECT article.*,c.category_name as cname,sc.category_name AS scgname,u.username "
					+ "FROM article "
					+ " INNER JOIN category c ON article.category_id = c.id"
					+ " INNER JOIN sys_category sc ON article.sys_category_id = sc.id"
					+ " INNER JOIN muser u ON article.user_id = u.id AND c.user_id = u.id "
					+" where article.is_delete=0 and article.user_id=? order by publish_time DESC) t where rownum<= ?) where num>= ?";
			artList = new ArrayList<Article>();
			rs=dbc.doQueryRS(sql, new Object[]{userId,start+size,start});
			while (rs.next()) {
				Article art = new Article();
				
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));
				try {
					art.setUsername(rs.getString("username"));
					art.setCategoryName(rs.getString("cname"));
					art.setScName(rs.getString("scgname"));
				} catch (Exception e) {
					art.setUsername("");
					art.setCategoryName("");
					art.setScName("");
				}
				
				artList.add(art);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			dbc.close();
		}
		
		return artList;
	}
	@Override
	public List<Article> getArticleByPageUserCategoryId(int curPage, int size, int userId,int categoryId) {
		ResultSet rs = null;
		List<Article> artList = null;
		int start = (curPage - 1) * size;	//limit从0开始
		DBPool dbc=new DBPool();
		try {
			String sql="select * from(select rownum num,t.* from(SELECT article.*,c.category_name as cname,sc.category_name AS scgname,u.username "
					+ "FROM article "
					+ " INNER JOIN category c ON article.category_id = c.id"
					+ " INNER JOIN sys_category sc ON article.sys_category_id = sc.id"
					+ " INNER JOIN muser u ON article.user_id = u.id AND c.user_id = u.id "
					+" where article.is_delete=0 and article.user_id=? and article.category_id=? order by publish_time DESC) t where rownum<= ?) where num>= ?";
			artList = new ArrayList<Article>();
			rs=dbc.doQueryRS(sql, new Object[]{userId,categoryId,start+size,start});
			while (rs.next()) {
				Article art = new Article();
				
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));
				try {
					art.setUsername(rs.getString("username"));
					art.setCategoryName(rs.getString("cname"));
					art.setScName(rs.getString("scgname"));
				} catch (Exception e) {
					art.setUsername("");
					art.setCategoryName("");
					art.setScName("");
				}
				
				artList.add(art);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			dbc.close();
		}
		
		return artList;
	}
	
	//相关分类的文章列表
	@Override
	public List<Article> getBycgIdorscgId(int cgId, int scgId, int artId) {	
		ResultSet rs = null;
		List<Article> artList = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select rownum num,t.* from(select * from article where is_delete=0 and id<>? and category_id=? and sys_category_id=? order by publish_time) t where rownum<= 5";
			artList = new ArrayList<Article>();
			rs=dbc.doQueryRS(sql, new Object[]{artId,cgId,scgId});	
			while (rs.next()) {
				Article art = new Article();
				
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));
				artList.add(art);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return artList;
	}
	
	@Override
	public List<Article> topTenArticle(){
		DBPool dbc=null;
		ResultSet rs=null;
		List<Article> artList = null;
		try {
			artList = new ArrayList<Article>();
			dbc=new DBPool();
			String sql="select rownum num,t.* from(select * from article ORDER BY count desc) t where rownum<= 10";
			rs=dbc.doQueryRS(sql, new Object[]{});
			while(rs.next()){
				Article art = new Article();
				art.setId(rs.getInt("id"));
				art.setTitle(rs.getString("title"));
				art.setUserId(rs.getInt("user_id"));
				art.setSysCategoryId(rs.getInt("sys_category_id"));
				art.setCategoryId(rs.getInt("category_id"));
				art.setContent(rs.getString("content"));
				art.setSummary(rs.getString("summary"));
				art.setPublishTime(rs.getTimestamp("publish_time"));
				art.setIsTop(rs.getInt("is_top"));
				art.setIsDelete(rs.getInt("is_delete"));
				art.setCount(rs.getInt("count"));
				artList.add(art);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			dbc.close();
		}
		return artList;
	}

	//文章点击数+1
	@Override
	public int updateCount(int artId) {
		DBPool dbc=new DBPool();
		int res=0;
		try {
			String sql="update article set count=count+1 where id=?";
			res=dbc.doUpdate(sql, new Object[]{artId});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	
}
