package cap.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cap.bean.Article;
import cap.bean.SysCategory;
import cap.bean.User;
import cap.service.ArticleService;
import cap.service.SysCategoryService;
import cap.service.impl.ArticleServiceImpl;
import cap.service.impl.SysCategoryServiceImpl;
import cap.util.PageControl;

//响应网站首页的Servelet
@WebServlet("/index.html")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArticleService artService;
	private SysCategoryService scService;
    
    public IndexServlet() {
    	artService=new ArticleServiceImpl();
    	scService=new SysCategoryServiceImpl();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action=request.getParameter("action");
		if(action!=null&&action.equals("indexFilter")){//过滤博文
			List<SysCategory> scList=scService.getAllSysCategory();//获取系统分类列表
			List<User> uList=artService.getActiveUser(2); //获取 2 个活跃人数
			List<Article> tenList=artService.topTenArticle();//获取博文top10
			//分页
			String curPageStr = request.getParameter("curPage");
			String sysCategoryId = request.getParameter("sysCategoryId");
			PageControl pc=artService.getFilterData(curPageStr,sysCategoryId);//获取当前页数博文数据
			
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());			
			request.setAttribute("uList", uList);
			request.setAttribute("scList", scList);
			request.setAttribute("tenList", tenList);
			request.setAttribute("artList", pc.getList());			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else{
			List<SysCategory> scList=scService.getAllSysCategory();//获取系统分类列表
			List<User> uList=artService.getActiveUser(2); //获取 2 个活跃人数
			List<Article> tenList=artService.topTenArticle();//获取博文top10
			//分页
			String curPageStr = request.getParameter("curPage");
			
			PageControl pc=artService.getData(curPageStr);//获取当前页数博文数据
			//Counter counter=counterService.getCounter();//网站计数
			
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());
			
			request.setAttribute("uList", uList);
			request.setAttribute("scList", scList);
			request.setAttribute("tenList", tenList);
			//request.setAttribute("counter", counter);
			request.setAttribute("artList", pc.getList());
			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
	}
}
