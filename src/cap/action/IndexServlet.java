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

//��Ӧ��վ��ҳ��Servelet
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
		if(action!=null&&action.equals("indexFilter")){//���˲���
			List<SysCategory> scList=scService.getAllSysCategory();//��ȡϵͳ�����б�
			List<User> uList=artService.getActiveUser(2); //��ȡ 2 ����Ծ����
			List<Article> tenList=artService.topTenArticle();//��ȡ����top10
			//��ҳ
			String curPageStr = request.getParameter("curPage");
			String sysCategoryId = request.getParameter("sysCategoryId");
			PageControl pc=artService.getFilterData(curPageStr,sysCategoryId);//��ȡ��ǰҳ����������
			
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());			
			request.setAttribute("uList", uList);
			request.setAttribute("scList", scList);
			request.setAttribute("tenList", tenList);
			request.setAttribute("artList", pc.getList());			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else{
			List<SysCategory> scList=scService.getAllSysCategory();//��ȡϵͳ�����б�
			List<User> uList=artService.getActiveUser(2); //��ȡ 2 ����Ծ����
			List<Article> tenList=artService.topTenArticle();//��ȡ����top10
			//��ҳ
			String curPageStr = request.getParameter("curPage");
			
			PageControl pc=artService.getData(curPageStr);//��ȡ��ǰҳ����������
			//Counter counter=counterService.getCounter();//��վ����
			
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
