package cap.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cap.bean.Article;
import cap.bean.BlogInfo;
import cap.bean.Category;
import cap.bean.Profile;
import cap.bean.SysCategory;
import cap.bean.User;
import cap.dao.ArticleDao;
import cap.dao.impl.ArticleDaoImpl;
import cap.service.ArticleService;
import cap.service.BlogInfoService;
import cap.service.CategoryService;
import cap.service.ProfileService;
import cap.service.SysCategoryService;
import cap.service.UserService;
import cap.service.impl.ArticleServiceImpl;
import cap.service.impl.BlogInfoServiceImpl;
import cap.service.impl.CategoryServcieImpl;
import cap.service.impl.ProfileServiceImpl;
import cap.service.impl.SysCategoryServiceImpl;
import cap.service.impl.UserServiceImpl;
import cap.util.PageControl;

//�û���ز���
@WebServlet("/user")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService userService;
	private SysCategoryService scService;
	private ArticleService artService;
	private BlogInfoService biService;
	private CategoryService categoryService;
	private ProfileService profileService;       
    
    public UserServlet() {
    	userService=new UserServiceImpl();
    	scService=new SysCategoryServiceImpl();
    	artService=new ArticleServiceImpl();
    	biService=new BlogInfoServiceImpl();
    	categoryService=new CategoryServcieImpl();
    	profileService=new ProfileServiceImpl();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action=request.getParameter("action");
		if(action.equals("login")){	//��½		
			String userName = request.getParameter("username");
			String password = request.getParameter("password");
			User u = userService.login(userName, password);
			
			if (null != u) {//��֤�ɹ�����Ҫ��is_delete				
				if (u.getIsDelete() == 0) { 	
					request.getSession().setAttribute("user", u);
					response.sendRedirect("user?action=index");
				} else {
					request.getSession().setAttribute("userIsDeleMsg", "���û��ѱ����ã��޷���¼��");
					response.sendRedirect("Login.jsp");
				}				
			} else {
				request.getSession().setAttribute("msg", "��֤ʧ�ܣ������������û��������룡");
				response.sendRedirect("Login.jsp");
			}
		}else if(action.equals("index")){//��ҳ
			//��ת����ҳ			
			List<SysCategory> scList = scService.getAllSysCategory();//��ȡϵͳ�����б�
			List<User> uList = artService.getActiveUser(2);	//��ȡ 2 ����Ծ����
			List<Article> tenList=artService.topTenArticle();//����top10
			//��ҳ
			String curPageStr = request.getParameter("curPage");//��ǰҳ��	
			PageControl pc=artService.getData(curPageStr);//��ǰҳ��������Ϣ
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getPageSize());			
			request.setAttribute("uList", uList);
			request.setAttribute("scList", scList);
			request.setAttribute("tenList", tenList);
			request.setAttribute("artList", pc.getList());
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else if(action.equals("myblog")){//��ȡ�������в���
			int userId = Integer.parseInt(request.getParameter("userId"));
			BlogInfo bi = biService.getByuserId(userId);//���˲�����Ϣ
			List<Category> cgList = categoryService.getByUserId(userId);//��ȡ�û��ĸ��˷���
			User u = userService.getUserById(userId);			
			if (null == bi) {
				response.sendRedirect("frame/404.jsp");
			} else {
				String blogName = bi.getBlogName();
				String blogPropagate = bi.getPropagate();
				
				String curPageStr = request.getParameter("curPage");
				PageControl pc=artService.getByPageUserId(curPageStr, userId);//��ȡ���ߵ�ǰҳ�벩��
				request.setAttribute("userId", userId);
				request.setAttribute("blogName", blogName);
				request.setAttribute("blogAnnoucement", blogPropagate);
				request.setAttribute("artList", pc.getList());
				request.setAttribute("cgList", cgList);
				request.setAttribute("blogInfo", bi);
				request.setAttribute("author", u.getUserName());
				request.setAttribute("curPage", pc.getCurPage());
				request.setAttribute("totalPages", pc.getTotalPages());
				request.getRequestDispatcher("MyBlogIndex.jsp").forward(request, response);
			}
		}else if(action.equals("myblogFilter")){//��ȡ�������в���
			int userId = Integer.parseInt(request.getParameter("userId"));
			int categoryId = Integer.parseInt(request.getParameter("categoryId"));
			BlogInfo bi = biService.getByuserId(userId);//���˲�����Ϣ
			List<Category> cgList = categoryService.getByUserId(userId);//��ȡ�û��ĸ��˷���
			User u = userService.getUserById(userId);			
			if (null == bi) {
				response.sendRedirect("frame/404.jsp");
			} else {
				String blogName = bi.getBlogName();
				String blogPropagate = bi.getPropagate();
				
				String curPageStr = request.getParameter("curPage");
				PageControl pc=artService.getByPageUserCategoryId(curPageStr, userId,categoryId);//��ȡ���ߵ�ǰҳ�벩��
				request.setAttribute("userId", userId);
				request.setAttribute("blogName", blogName);
				request.setAttribute("blogAnnoucement", blogPropagate);
				request.setAttribute("artList", pc.getList());
				request.setAttribute("cgList", cgList);
				request.setAttribute("blogInfo", bi);
				request.setAttribute("author", u.getUserName());
				request.setAttribute("curPage", pc.getCurPage());
				request.setAttribute("totalPages", pc.getTotalPages());
				request.getRequestDispatcher("MyBlogIndex.jsp").forward(request, response);
			}
		}else if(action.equals("register")){//ע��
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			int userId = userService.getIdByuserName(username); //����username��ѯ�û�id
			User u = userService.getByEmail(email);	//����email��ѯ�û�
			
			if ((userId > 0) || (null != u)) {
				request.getSession().setAttribute("existMsg", "�û����������ѱ�ע�ᣬ��������д��");				
			} else {
				int res = userService.register(email, username, password);				
				if (res > 0) {//ע��ɹ�!
					request.getSession().setAttribute("succMsg", "ע��ɹ�");
				} else {
					request.setAttribute("errorMsg", "ע��ʧ�ܣ���������д�û���Ϣ��");
				}
			}
			response.sendRedirect("Register.jsp");
		}else if(action.equals("apply")){//����ע�Ὺͨ����
			int userId = Integer.parseInt(request.getParameter("userId"));
			String blogName = request.getParameter("blog_name");
			String description = request.getParameter("description");
			String annoucement = request.getParameter("annoucement");
			BlogInfo bi = biService.getByuserId(userId);		
			int res = -1;
			
			if (null != bi) {
				res = biService.updateBlogInfo(userId, blogName, description, annoucement);
				bi = biService.getByuserId(userId);
			} else {
				res = biService.insertBlogInfo(userId, blogName, description, annoucement);//��ͨ����
			}
				
			if (res > 0) {			
				userService.setIsAppliedById(userId);				
				 //����Ĭ�Ϸ���
				categoryService.insertCategory(userId, "�޷���");				
				User u = userService.getUserById(userId);		//��ѯ���µ��û���Ϣ
				String succMsg = "���벩�ͳɹ���";				
				request.getSession().setAttribute("user", u);
				request.getSession().setAttribute("succMsg", succMsg);
			} else {
				String errorMsg = "���벩��ʧ�ܣ�";
				request.getSession().setAttribute("errorMsg", errorMsg);
			}
			
			response.sendRedirect("ApplyBlog.jsp");
		}else if(action.equals("profile")){//�༭������Ϣ
			//ת��������ҳ
			int id = Integer.parseInt(request.getParameter("id"));			
			User u = userService.getUserById(id);//����id��ȡ�û�����			
			Profile pf = profileService.getByuserId(id);//����id��ȡ������Ϣ		
			if (null != pf) {
				request.setAttribute("profile", pf);
			}			
			request.getSession().setAttribute("user", u);
			request.getRequestDispatcher("Profile.jsp").forward(request, response);
		}else if(action.equals("logout")){//�ǳ�
			request.setCharacterEncoding("utf-8");		
			HttpSession session = request.getSession(false); //��ֹ����Session			
			if (null == session) {
				response.sendRedirect("user?action=index");
				return;
			}			
			session.removeAttribute("user");
			response.sendRedirect("user?action=index");
		}else if(action.equals("myblogindex")){//�ҵĲ���
			int userId = Integer.parseInt(request.getParameter("userId"));
			BlogInfo bi = biService.getByuserId(userId);
			List<Category> cgList = categoryService.getByUserId(userId);    //��ȡ�û��ĸ��˷���			
			ArticleDao artDao = new ArticleDaoImpl();
			User u = userService.getUserById(userId);
			
			if (null == bi) {
				//��ת��404ҳ��
				response.sendRedirect("templates/404.jsp");
			} else {
				String blogName = bi.getBlogName();
				String blogAnnoucement = bi.getPropagate();				
				String curPageStr = request.getParameter("curPage");
				PageControl pc=artService.getByPageUserId(curPageStr, userId);				
				request.setAttribute("userId", userId);
				request.setAttribute("blogName", blogName);
				request.setAttribute("blogAnnoucement", blogAnnoucement);
				request.setAttribute("artList", pc.getList());
				request.setAttribute("cgList", cgList);
				request.setAttribute("blogInfo", bi);
				request.setAttribute("author", u.getUserName());
				request.setAttribute("curPage", pc.getCurPage());
				request.setAttribute("totalPages", pc.getTotalPages());
				request.getRequestDispatcher("MyBlogIndex.jsp").forward(request, response);
			}
		}else if(action.equals("search")){//����վ������
			String q = request.getParameter("q");			
			List<Article> artList = artService.search(q);
			request.setAttribute("q", q);
			request.setAttribute("artList", artList);
			request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
		}else if(action.equals("updatepass")){//�޸�����
			String oldPwd = request.getParameter("old_pwd");
			String newPwd = request.getParameter("new_pwd");
			int userId = Integer.parseInt(request.getParameter("userId"));
			User u = userService.getByIdPwd(userId, oldPwd);//����userId��password��ѯ�û���¼			
			if (null != u) {//��֤�ɹ���������������
				int res = userService.updatePwdById(userId, newPwd);				
				if (res > 0) {
					request.getSession().setAttribute("succUpdateMsg", "�޸�����ɹ���");
				} else {
					request.getSession().setAttribute("errorUpdateMsg", "�޸�����ʧ�ܣ�");
				}				
			} else {//��֤ʧ��
				request.getSession().setAttribute("validPwdMsg", "��������֤ʧ�ܣ���������д��");
			}			
			response.sendRedirect("user?action=profile&id="+userId);
		}else if(action.equals("updateprofile")){//���¸�����Ϣ			
			int userId = Integer.parseInt(request.getParameter("id"));
			String firstName = request.getParameter("first_name");		
			String lastName = request.getParameter("last_name");
			String genderVal = request.getParameter("gender");	//ȡ��������Ů -> 1,0
			int gender = genderVal.equals("male") ? 1 : 0;
			String telephone = request.getParameter("telephone");
			Profile pf = profileService.getByuserId(userId);
			int res = -1;
			int resOfpf = -1;
			
			if (null != pf) {
				res = profileService.updateProfile(userId, firstName, lastName, gender, telephone);//����и�����Ϣ�������
				pf = profileService.getByuserId(userId);				
			} else {
				res = profileService.insertProfile(userId, firstName, lastName, gender, telephone);//����޸�����Ϣ�����½�
			}
				
			if (res > 0) {
				resOfpf = userService.setIsProfile(userId);//���ø�����Ϣ����				
				String succMsg = "���¸������ϳɹ���";
				request.getSession().setAttribute("succMsg", succMsg);
			} else {
				String errorMsg = "���¸�������ʧ�ܣ�";
				request.getSession().setAttribute("errorMsg", errorMsg);
			}
			response.sendRedirect("user?action=profile&id="+userId);
		}else if(action.equals("bloginfo")){//�༭������Ϣ
			int userId = Integer.parseInt(request.getParameter("userId"));
			BlogInfo bi = biService.getByuserId(userId);//����userId��ȡ������Ϣ		
			request.setAttribute("bi", bi);
			request.getRequestDispatcher("BlogInfo.jsp").forward(request, response);
		}else if(action.equals("updatebloginfo")){//���¸��˲�����Ϣ
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			int userId = Integer.parseInt(request.getParameter("userId"));
			String blogName = request.getParameter("blog_name");
			String description = request.getParameter("description");
			String propagate = request.getParameter("propagate");
			int res = biService.updateBlogInfo(userId, blogName, description, propagate);//���¸��˲�����Ϣ
			
			if (res > 0) {    //���²�����Ϣ�ɹ�
				request.getSession().setAttribute("succUpdateMsg", "���²�����Ϣ�ɹ���");
			} else {
				request.getSession().setAttribute("errorUpdateMsg", "���²�����Ϣʧ�ܣ�");
			}
			
			response.sendRedirect("user?action=bloginfo&userId="+userId);
		}
	}

}