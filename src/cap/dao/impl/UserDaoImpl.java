package cap.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cap.bean.User;
import cap.dao.UserDao;
import cap.db.DBPool;

public class UserDaoImpl implements UserDao {
	@Override
	public User login(String userName, String password) {
		User u = null;
		ResultSet rs = null;
		DBPool dbc=new DBPool();
		try {
			u = new User();
			String sql="select * from muser where username=? and password=?";
			rs=dbc.doQueryRS(sql, new Object[]{userName,password});
			if (rs.next()) {
				u.setId(rs.getInt("id"));
				u.setEmail(rs.getString("email"));
				u.setUserName(rs.getString("username"));
				u.setIsApplied(rs.getInt("is_applied"));
				u.setIsDelete(rs.getInt("is_delete"));
				u.setIsProfile(rs.getInt("is_profile"));
				
			} else {
				u = null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return u;
	}
	//ע��
	@Override
	public int register(String email, String username, String password) {
		User u = null;

		int res = -1;
		DBPool dbc=new DBPool();
		try {
			u = new User();
			String sql="insert into muser (username,password,email,is_applied,is_delete,is_profile) values(?, ?, ?, 0, 0, 0)";
			res = dbc.doUpdate(sql, new Object[]{username,password,email});

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}

	//����username��ѯ�û����Ƿ����
	@Override
	public int getIdByuserName(String username) {
		int userid = 0;
		DBPool dbc=new DBPool();
		ResultSet rs = null;
		
		try {
			String sql="select id from muser where username=?";
			rs = dbc.doQueryRS(sql, new Object[]{username});
			if (rs.next()) {
				userid = rs.getInt("id");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return userid;
	}
	
	//��ȡ�����û�
	@Override
	public List<User> getAllUser() {
		List<User> uList = null;
		ResultSet rs = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select * from muser";
			uList = new ArrayList<User>();
			rs=dbc.doQueryRS(sql, new Object[]{});
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setEmail(rs.getString("email"));
				u.setUserName(rs.getString("username"));
				u.setIsApplied(rs.getInt("is_applied"));
				u.setIsDelete(rs.getInt("is_delete"));
				u.setIsProfile(rs.getInt("is_profile"));
				
				uList.add(u);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return uList;
	}
	
	//����id��ѯ�û�
	@Override
	public User getUserById(int id) {
		User u = null;
		ResultSet rs = null;
		DBPool dbc=new DBPool();
		try {
			u = new User();
			String sql="select * from muser where id=?";
			rs = dbc.doQueryRS(sql, new Object[]{id});
			while (rs.next()) {
				u.setId(rs.getInt("id"));
				u.setEmail(rs.getString("email"));
				u.setUserName(rs.getString("username"));
				u.setIsApplied(rs.getInt("is_applied"));
				u.setIsDelete(rs.getInt("is_delete"));
				u.setIsProfile(rs.getInt("is_profile"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return u;
	}
	
	@Override
	public int setIsAppliedById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int res = -1;
		DBPool dbc=new DBPool();
		try {
			String sql="update muser set is_applied=1 where id=?";
			res=dbc.doUpdate(sql, new Object[]{id});
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}
	
	//����userId��password��ѯ�û���¼
	@Override
	public User getByIdPwd(int userId, String password) {
		User u = null;
		ResultSet rs = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select * from muser where id=? and password=?";
			rs=dbc.doQueryRS(sql, new Object[]{userId,password});
			while (rs.next()) {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setEmail(rs.getString("email"));
				u.setUserName(rs.getString("username"));
				u.setIsApplied(rs.getInt("is_applied"));
				u.setIsDelete(rs.getInt("is_delete"));
				u.setIsProfile(rs.getInt("is_profile"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return u;
	}
	
	//��������
	@Override
	public int updatePwdById(int userId, String password) {
		int res = -1;
		DBPool dbc=new DBPool();
		try {
			String sql="update muser set password=? where id=?";
			res=dbc.doUpdate(sql, new Object[]{password,userId});
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return res;
	}
	
	//����email��ѯ�û��Ƿ����
	@Override
	public User getByEmail(String email) {
		User u = null;
		ResultSet rs = null;
		DBPool dbc=new DBPool();
		try {
			String sql="select * from muser where email=?";

			rs=dbc.doQueryRS(sql, new Object[]{email});
			while (rs.next()) {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setEmail(rs.getString("email"));
				u.setUserName(rs.getString("username"));
				u.setIsApplied(rs.getInt("is_applied"));
				u.setIsDelete(rs.getInt("is_delete"));
				u.setIsProfile(rs.getInt("is_profile"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return u;
	}
	
	//�����˺�
	@Override
	public int deleteUser(int uId){
		DBPool dbc=new DBPool();
		int res = -1;
		try {
			String sql="update muser set is_delete=1 where id=?";
			res=dbc.doUpdate(sql, new Object[]{uId});
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		return res;
	}
	
	//�����˺�
	@Override
	public int activeUser(int uId){
		int res = -1;
		DBPool dbc=new DBPool();
		try{
			String sql="update muser set is_delete=0 where id=?";

			res=dbc.doUpdate(sql, new Object[]{uId});
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbc.close();
		}
		return res;
	}
	
	//���ø�����Ϣ����
	@Override
	public int setIsProfile(int userId) {
		int res = -1;
		DBPool dbc=new DBPool();
		try {
			String sql="update muser set is_profile=1 where id=?";
			res=dbc.doUpdate(sql, new Object[]{userId});
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			dbc.close();
		}
		
		return res;
	}
	
	//��ȡ��ǰҳ����û���Ϣ
	@Override
	public List<User> getUserByPage(int curPage, int size) {
		DBPool dbc=new DBPool();
		ResultSet rs = null;
		List<User> uList = null;
		int start = (curPage - 1) * size;	//limit��0��ʼ
		
		try {
			String sql="select * from(select rownum num,t.* from(select * from muser) t where rownum<= ?) where num>= ?";
			uList = new ArrayList<User>();
			rs=dbc.doQueryRS(sql, new Object[]{start+size,start});
			while (rs.next()) {
				User u = new User();				
				u.setId(rs.getInt("id"));
				u.setEmail(rs.getString("email"));
				u.setUserName(rs.getString("username"));
				u.setIsApplied(rs.getInt("is_applied"));
				u.setIsDelete(rs.getInt("is_delete"));
				u.setIsProfile(rs.getInt("is_profile"));				
				uList.add(u);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbc.close();
		}
		
		return uList;
	}
}
