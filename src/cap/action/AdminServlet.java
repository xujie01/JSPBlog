package cap.action;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import cap.bean.Admin;
import cap.bean.Article;
import cap.bean.Comment;
import cap.bean.Counter;
import cap.bean.Profile;
import cap.bean.SysCategory;
import cap.bean.User;
import cap.service.AdminService;
import cap.service.ArticleService;
import cap.service.CommentService;
import cap.service.CounterService;
import cap.service.ProfileService;
import cap.service.SysCategoryService;
import cap.service.UserService;
import cap.service.impl.AdminServiceImpl;
import cap.service.impl.ArticleServiceImpl;
import cap.service.impl.CommentServiceImpl;
import cap.service.impl.CounterServiceImpl;
import cap.service.impl.ProfileServiceImpl;
import cap.service.impl.SysCategoryServiceImpl;
import cap.service.impl.UserServiceImpl;
import cap.util.PageControl;

//管理员相关操作
@WebServlet("/admin.html")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService;
	private UserService userService;
	private ProfileService profileService;
	private ArticleService artService;
	private SysCategoryService scService;
	private CounterService cntService;
	private CommentService cmtService;       
    
    public AdminServlet() {
    	adminService=new AdminServiceImpl();
    	userService=new UserServiceImpl();
    	profileService=new ProfileServiceImpl();
    	artService=new ArticleServiceImpl();
    	scService=new SysCategoryServiceImpl();
    	cntService=new CounterServiceImpl();
    	cmtService=new CommentServiceImpl();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		request.setCharacterEncoding("UTF-8");
		String action=request.getParameter("action");
		if(action.equals("login")){//管理员登陆
			String userName = request.getParameter("username");
			String passWord = request.getParameter("password");
			Admin admin = adminService.login(userName, passWord);
			
			if (admin == null) {
				request.getSession().setAttribute("msg", "用户名或密码不正确！");
				response.sendRedirect("AdminLogin.jsp");
			} else {
				request.getSession().setAttribute("admin", admin);
				response.sendRedirect("admin.html?action=index");
			}			
		}else if(action.equals("logout")){//登出
			HttpSession session = request.getSession(false);//防止创建Session			
			if (null != session) {
				session.removeAttribute("admin");
			}
			
			request.getSession().setAttribute("logoutMsg", "退出成功！");
			response.sendRedirect("AdminLogin.jsp");			
		}else if(action.equals("index")){//管理员页面		
			List<Article> artList = artService.getAllArtical(); //获取所有文章		
			List<Comment> cmtList = cmtService.getAll(); //获取所有评论	
			List<User> uList = userService.getAllUser(); //获取所有用户
			Counter cnt = cntService.getCounter();//获取网站来访数
			request.setAttribute("artList", artList);
			request.setAttribute("cmtList", cmtList);
			request.setAttribute("uList", uList);
			request.setAttribute("cnt", cnt);
			request.getRequestDispatcher("admin/index.jsp").forward(request, response);
		}	
		else if(action.equals("useradmin")){//用户管理
			String curPageStr = request.getParameter("curPage");//分页
			PageControl pc=userService.getUserOfPage(curPageStr);//获取当前页码的用户信息
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());
			
			request.setAttribute("uList", pc.getList());
			request.getRequestDispatcher("admin/UserAdmin.jsp").forward(request, response);
		}else if(action.equals("userprofile")){//用户详细信息				
			int userId = Integer.parseInt(request.getParameter("uId"));
			Profile pf = profileService.getByuserId(userId);//用户详细信息			
			request.setAttribute("pf", pf);
			request.getRequestDispatcher("/admin/UserProfile.jsp").forward(request, response);
			
		}else if(action.equals("deleteuser")){//禁用账号
			int uId = Integer.parseInt(request.getParameter("uId"));
			int res = userService.deleteUser(uId);
			
			if (res > 0) {	//删除成功
				request.getSession().setAttribute("succDeleMsg", "禁用账户成功！");
			} else {     //删除失败
				request.getSession().setAttribute("errorDeleMsg", "禁用账户失败！");
			}
			
			response.sendRedirect("admin.html?action=useradmin");
		}else if(action.equals("activeuser")){//激活账号			
			int uId = Integer.parseInt(request.getParameter("uId"));
			int res = userService.activeUser(uId);
			
			if (res > 0) {	//激活成功
				request.getSession().setAttribute("succActMsg", "激活账户成功！");
			} else {     //激活失败
				request.getSession().setAttribute("errorActMsg", "激活账户失败！");
			}			
			response.sendRedirect("admin.html?action=useradmin");
			
		}else if(action.equals("SysArticalAdmin")){//文章管理
			String curPageStr = request.getParameter("curPage");
			PageControl pc = artService.getData(curPageStr);//获取当前页码文章信息
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());
			List<Article> artList=pc.getList();
			request.setAttribute("artList", artList);
			request.getRequestDispatcher("admin/SysArticleAdmin.jsp").forward(request, response);	
			
		}else if(action.equals("DeleteSysArtical")){//删除文章
			int artId = Integer.parseInt(request.getParameter("artId"));
			int res = artService.deleteArtical(artId);
			
			if (res > 0) {	//删除成功
				request.getSession().setAttribute("deleSuccMsg", "删除成功！");
			} else {
				request.getSession().setAttribute("deleErrorMsg", "删除失败！");
			}			
			response.sendRedirect("admin.html?action=SysArticalAdmin");
		}else if(action.equals("SysCategoryAdmin")){//分类管理
			String curPageStr = request.getParameter("curPage");
			PageControl pc=scService.getSysCategoryByPage(curPageStr);//获取当前页码系统分类
			request.setAttribute("scgList", pc.getList());
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());
			request.getRequestDispatcher("admin/SysCategoryAdmin.jsp").forward(request, response);
		}else if(action.equals("EditSysCategory")){//编辑系统分类
			int scgId = Integer.parseInt(request.getParameter("scgId"));
			SysCategory scg = scService.getById(scgId);			
			request.setAttribute("scg", scg);
			request.getRequestDispatcher("admin/EditSysCategory.jsp").forward(request, response);
		}else if(action.equals("SaveEditSysCategory")){//保存系统分类编辑
			int scgId = Integer.parseInt(request.getParameter("scgId"));			
			String scgName = request.getParameter("scgName");
			SysCategory scg = scService.getByName(scgName);
			
			if ((null != scg) && (scgId != scg.getId())) {
				request.getSession().setAttribute("scgExist", "该分类名已存在，请重新输入分类名！");
				response.sendRedirect("EditSysCategory.html?scgId="+scgId);
				
			} else {//允许更新该分类名
				int res = scService.updateSysCategory(scgId, scgName);
				
				if (res > 0) {	//更新成功
					request.getSession().setAttribute("succUpdateScg", "更新分类成功！");
					response.sendRedirect("admin.html?action=SysCategoryAdmin");
				} else {
					request.getSession().setAttribute("errorUpdateScg", "更新分类失败！");
					response.sendRedirect("admin.html?action=SysCategoryAdmin");
				}
			}
		}else if(action.equals("AddSysCategory")){//添加系统分类
			String scgName = request.getParameter("scgName");
			SysCategory scg = scService.getByName(scgName);
			
			if (null != scg) {    //提示该分类已存在
				request.getSession().setAttribute("scgExist", "该分类名已存在，请重新输入分类名！");
				response.sendRedirect("admin/AddSysCategory.jsp");
				
			} else {
				int res = scService.insertSysCategory(scgName);
				
				if (res > 0) {	  //添加分类成功
					request.getSession().setAttribute("succAddScg", "添加分类成功！");
				} else {		  //添加分类失败
					request.getSession().setAttribute("errorAddScg", "添加分类失败！");
				}
				
				response.sendRedirect("admin.html?action=SysCategoryAdmin");
			}
		}else if(action.equals("DeleteSysCategory")){
			int scgId = Integer.parseInt(request.getParameter("scgId"));
			//SysCategoryDao scgDao = new SysCategoryDao();
			int res = scService.deleteSysCategory(scgId);
			
			if (res > 0) {
				request.getSession().setAttribute("succDeleScg", "删除分类成功！");
			} else {
				request.getSession().setAttribute("errorDeleScg", "删除分类失败！");
			}
			
			response.sendRedirect("admin.html?action=SysCategoryAdmin");
		}
	}

	

	
}
