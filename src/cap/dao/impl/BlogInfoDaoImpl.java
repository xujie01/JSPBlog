package cap.dao.impl;


import java.sql.ResultSet;
import java.sql.SQLException;

import cap.bean.BlogInfo;
import cap.dao.BlogInfoDao;
import cap.db.DBPool;

public class BlogInfoDaoImpl implements BlogInfoDao {

	//开通博客
	@Override
	public int insertBlogInfo(int userId, String blogName, String description, String annoucement) {
		int res = -1;
		DBPool dbc=new DBPool();
		try {
			String sql="insert into blog_info values(NULL, ?, ?, ?, ?)";
			res=dbc.doUpdate(sql, new Object[]{userId,blogName,description,annoucement});
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}
	
	//根据userId获取博客信息
	@Override
	public BlogInfo getByuserId(int userId) {
		ResultSet rs = null;
		BlogInfo bi = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select rownum num,t.* from(select * from blog_info where user_id=?) t where rownum<= 1";
			rs=dbc.doQueryRS(sql, new Object[]{userId})	;	
			if (rs.next()) {
				bi = new BlogInfo(); 
				
				bi.setId(rs.getInt("id"));
				bi.setUserId(rs.getInt("user_id"));
				bi.setBlogName(rs.getString("blog_name"));
				bi.setDescription(rs.getString("description"));
				bi.setPropagate(rs.getString("propagate"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return bi;
	}
	
	//更新个人博客信息
	@Override
	public int updateBlogInfo(int userId, String blogName, String description, String propagate) {		

		int res = -1;
		DBPool dbc=new DBPool();
		try {
			String sql="update blog_info " +
					"set blog_name=?, description=?, propagate=? where user_id=?";
			res=dbc.doUpdate(sql, new Object[]{blogName,description,propagate,userId});
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}
}
