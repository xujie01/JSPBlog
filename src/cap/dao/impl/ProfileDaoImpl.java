package cap.dao.impl;


import java.sql.ResultSet;
import java.sql.SQLException;

import cap.bean.Profile;
import cap.dao.ProfileDao;
import cap.db.DBPool;

public class ProfileDaoImpl implements ProfileDao {
	
	//插入个人信息
	@Override
	public int insertProfile(int userId, String firstName, String lastName, int gender, String telephone) {

		int res = -1;
		DBPool dbc=new DBPool();
		try {
			String sql="insert into profile (user_id,first_name,last_name,gender,telephone) values(?, ?, ?, ?, ?)";
			res=dbc.doUpdate(sql, new Object[]{userId,firstName,lastName,gender,telephone});
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}

	//根据userId查询个人信息
	@Override
	public Profile getByuserId(int userId) {
		ResultSet rs = null;
		Profile pf = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select rownum num,t.* from(select * from profile where user_id=?) t where rownum<= 1";
			rs=dbc.doQueryRS(sql, new Object[]{userId});	
			if (rs.next()) {
				pf = new Profile();
				
				pf.setId(rs.getInt("id"));
				pf.setUserId(rs.getInt("user_id"));
				pf.setFirstName(rs.getString("first_name"));
				pf.setLastName(rs.getString("last_name"));
				pf.setGender(rs.getInt("gender"));
				pf.setTelephone(rs.getString("telephone"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return pf;
	}
	
	//更新个人信息
	@Override
	public int updateProfile(int userId, String firstName, String lastName, int gender, String telephone) {

		int res = -1;
		DBPool dbc=new DBPool();
		try {
			String sql="update profile " +
			           "set first_name=?, last_name=?, gender=?, telephone=? where user_id=?";
			res=dbc.doUpdate(sql, new Object[]{firstName,lastName,gender,telephone,userId});
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}
	
}
