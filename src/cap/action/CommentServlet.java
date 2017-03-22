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

//�������鼰����
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
		if (action.equals("manage")) {//�������۹���
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
		} else if (action.equals("commit")) {//�ύ��������
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
					succMsg = "�������³ɹ���";
				} else {
					errorMsg = "��������ʧ�ܣ�";
				}
				request.getSession().setAttribute("succMsg", succMsg);
				request.getSession().setAttribute("errorMsg", errorMsg);
				response.sendRedirect("comment.html?action=post&artId=" + artId + "&userId="
						+ userId);
			}
		}else if(action.equals("delete")){//��������ɾ��
			int userId = Integer.parseInt(request.getParameter("userId"));
			int cmtId = Integer.parseInt(request.getParameter("cmtId"));
			int res = cmtService.deleteComment(cmtId);
			
			if (res > 0) {
				request.getSession().setAttribute("succDeleMsg", "ɾ�����۳ɹ���");
			} else {
				request.getSession().setAttribute("errorDeleMsg", "ɾ������ʧ�ܣ�");
			}
			
			response.sendRedirect("comment.html?action=manage&userId="+userId);
		}else if(action.equals("post")){//��ȡ��������
			int artId = Integer.parseInt(request.getParameter("artId"));
			int userId = Integer.parseInt(request.getParameter("userId"));			
			
			userService=new UserServiceImpl();		
			artService=new ArticleServiceImpl();			
			scService=new SysCategoryServiceImpl();			
			cgService=new CategoryServcieImpl();
			
			User u = userService.getUserById(userId);//��ȡ����������Ϣ
			String author = u.getUserName();
			
			Article art = artService.getById(artId);//����ID��ȡ��������
			artService.updateCount(artId);//���µ����+1
			int sysCgId = art.getSysCategoryId();
			int cgId = art.getCategoryId();
			
			SysCategory scg =  scService.getById(sysCgId);//����ID��ȡϵͳ������Ϣ
			Category cg = cgService.getById(cgId);//����ID��ȡ���˷�����Ϣ
			
			List<Article> artList = artService.getBycgIdorscgId(cgId, sysCgId, artId);//��ط���������б�
			List<Comment> cmtList = cmtService.getAllByArtId(artId);//��ȡ���¶�Ӧ������
			
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