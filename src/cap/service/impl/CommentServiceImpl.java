package cap.service.impl;

import java.util.List;

import cap.bean.Comment;
import cap.bean.Ucomment;
import cap.dao.CommentDao;
import cap.dao.impl.CommentDaoImpl;
import cap.service.CommentService;
import cap.util.PageControl;

public class CommentServiceImpl implements CommentService {
	private CommentDao commentDao;
	
	public CommentServiceImpl() {
		commentDao=new CommentDaoImpl();
	}
	
	@Override
	public int insertComment(int userId, int artId, String content){
		return commentDao.insertComment(userId, artId, content);
	}
	
	//博文评论删除
	@Override
	public int deleteComment(int cmtId){
		return commentDao.deleteComment(cmtId);
	}
	
	
	@Override
	public List<Comment> getAllByArtId(int artId){
		return commentDao.getAllByArtId(artId);
	}

	//根据userID获取博文及评论
	@Override
	public PageControl getCommentByUserId(String curPageStr,int userId){
		int total=commentDao.getCountByUserId(userId);
		PageControl pc = new PageControl(curPageStr, total);
		List<Ucomment> cmtList=commentDao.getCommentByPageUserId(pc.getCurPage(), pc.getPageSize(), userId);
		pc.setList(cmtList);
		return pc;
	}

	//获取所有评论
	@Override
	public List<Comment> getAll() {
		// TODO Auto-generated method stub
		return commentDao.getAll();
	}
	

}
