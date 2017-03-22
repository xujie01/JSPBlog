package cap.dao;

import java.util.List;

import cap.bean.Comment;
import cap.bean.Ucomment;

public interface CommentDao {

	/**
	 * 插入一条评论记录
	 * 
	 * return 影响行数
	 */
	public abstract int insertComment(int userId, int artId, String content);

	/**
	 * 根据artId获取所有评论
	 */
	public abstract List<Comment> getAllByArtId(int artId);

	/**
	 * 删除一条评论
	 * 
	 * return 影响行数
	 */
	public abstract int deleteComment(int cmtId);

	/**
	 * 获取所有评论
	 */
	public abstract List<Comment> getAll();

	public abstract List<Comment> getCommentByPage(int curPage, int size);

	public abstract List<Ucomment> getCommentByPageUserId(int curPage, int size,
			int userId);

	public abstract int getCountByUserId(int userId);

}