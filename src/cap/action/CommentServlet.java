package cap.action;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cap.bean.Article;
import cap.bean.Category;
import cap.bean.Comment;
import cap.bean.SysCategory;
import cap.bean.User;
import cap.service.ArticleService;
import cap.service.CategoryService;
import cap.service.CommentService;
import cap.service.SysCategoryService;
import cap.service.UserService;
import cap.service.impl.ArticleServiceImpl;
import cap.service.impl.CategoryServcieImpl;
import cap.service.impl.CommentServiceImpl;
import cap.service.impl.SysCategoryServiceImpl;
import cap.service.impl.UserServiceImpl;
import cap.util.PageControl;

//博文详情及评论
@WebServlet("/comment.html")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommentService cmtService;
	private UserService userService;
	private ArticleService artService;
	private SysCategoryService scService;
	private CategoryService cgService;
	
	public CommentServlet() {
		cmtService=new CommentServiceImpl();
	}	
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {	
		String action = request.getParameter("action");		
		if (action.equals("manage")) {//博文评论管理
			int userId = Integer.parseInt(request.getParameter("userId"));
			if (userId == 0) { 
				request.setAttribute("notFound", true);
			}
			String curPageStr = request.getParameter("curPage");			
			PageControl pc =cmtService.getCommentByUserId(curPageStr, userId);			
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());			
			request.setAttribute("cmtList", pc.getList());	
			request.getRequestDispatcher("CommentManage.jsp").forward(request,
					response);
		} else if (action.equals("commit")) {//提交博文评论
			int userId = Integer.parseInt(request.getParameter("userId"));
			int artId = Integer.parseInt(request.getParameter("artId"));
			String content = request.getParameter("comment_content");

			if (userId == 0) { 
				response.sendRedirect("Login.jsp");
			} else { 
				int res = cmtService.insertComment(userId, artId, content);
				String errorMsg = null;
				String succMsg = null;
				if (res > 0) {
					succMsg = "评论文章成功！";
				} else {
					errorMsg = "评论文章失败！";
				}
				request.getSession().setAttribute("succMsg", succMsg);
				request.getSession().setAttribute("errorMsg", errorMsg);
				response.sendRedirect("comment.html?action=post&artId=" + artId + "&userId="
						+ userId);
			}
		}else if(action.equals("delete")){//博文评论删除
			int userId = Integer.parseInt(request.getParameter("userId"));
			int cmtId = Integer.parseInt(request.getParameter("cmtId"));
			int res = cmtService.deleteComment(cmtId);
			
			if (res > 0) {
				request.getSession().setAttribute("succDeleMsg", "删除评论成功！");
			} else {
				request.getSession().setAttribute("errorDeleMsg", "删除评论失败！");
			}
			
			response.sendRedirect("comment.html?action=manage&userId="+userId);
		}else if(action.equals("post")){//获取博文详情
			int artId = Integer.parseInt(request.getParameter("artId"));
			int userId = Integer.parseInt(request.getParameter("userId"));			
			
			userService=new UserServiceImpl();		
			artService=new ArticleServiceImpl();			
			scService=new SysCategoryServiceImpl();			
			cgService=new CategoryServcieImpl();
			
			User u = userService.getUserById(userId);//获取文章作者信息
			String author = u.getUserName();
			
			Article art = artService.getById(artId);//根据ID获取博文详情
			artService.updateCount(artId);//文章点击数+1
			int sysCgId = art.getSysCategoryId();
			int cgId = art.getCategoryId();
			
			SysCategory scg =  scService.getById(sysCgId);//根据ID获取系统分类信息
			Category cg = cgService.getById(cgId);//根据ID获取个人分类信息
			
			List<Article> artList = artService.getBycgIdorscgId(cgId, sysCgId, artId);//相关分类的文章列表
			List<Comment> cmtList = cmtService.getAllByArtId(artId);//获取文章对应的评论
			
			request.setAttribute("author", author);
			request.setAttribute("art", art);
			request.setAttribute("scg", scg);
			request.setAttribute("cg", cg);
			request.setAttribute("cmtList", cmtList);
			request.setAttribute("artList", artList);
			request.getRequestDispatcher("/Post.jsp").forward(request, response);
		}
	}

}
