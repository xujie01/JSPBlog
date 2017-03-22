package cap.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cap.bean.Category;
import cap.service.CategoryService;
import cap.service.impl.CategoryServcieImpl;
import cap.util.PageControl;

//个人文章分类管理
@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CategoryService cgService;

    public CategoryServlet() {
    	cgService=new CategoryServcieImpl();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		request.setCharacterEncoding("UTF-8");
		String action=request.getParameter("action");
		if(action.equals("manage")){//管理个人文章分类
			int userId = Integer.parseInt(request.getParameter("userId"));
			int total=cgService.getByUserId(userId).size();
			//添加用于分页
			String curPageStr = request.getParameter("curPage");
			PageControl pc=cgService.getCategoryByUserId(curPageStr, userId);//个人分类
			request.setAttribute("curPage", pc.getCurPage());
			request.setAttribute("totalPages", pc.getTotalPages());
			
			request.setAttribute("cgList", pc.getList());
			request.getRequestDispatcher("CategoryManage.jsp").forward(request, response);
		}
		else if(action.equals("add")){//添加个人文章分类
			int userId = Integer.parseInt(request.getParameter("userId"));
			String cgName = request.getParameter("category_name");
			Category cg = cgService.getByName(cgName, userId);
			
			if (null == cg) {	//允许新建该分类
				int res = cgService.insertCategory(userId, cgName);
				
				if (res > 0) {
					request.getSession().setAttribute("succAddMsg", "添加分类成功！");
					response.sendRedirect("category?action=manage&userId="+userId);
				} else {
					request.getSession().setAttribute("errorAddMsg", "添加分类失败！");
					response.sendRedirect("category?action=manage&userId="+userId);
				}
				
			} else {//该分类已存在
				request.getSession().setAttribute("errorAddMsg", "该分类名已存在，请重新填写！");
				response.sendRedirect("AddCategory.jsp");
			}
		}else if(action.equals("edit")){//编辑个人文章分类
			int cgId = Integer.parseInt(request.getParameter("cgId"));
			Category cg = cgService.getById(cgId);			
			request.setAttribute("cg", cg);
			request.getRequestDispatcher("EditCategory.jsp").forward(request, response);
			
		}else if(action.equals("save")){//更新个人文章分类
			int cgId = Integer.parseInt(request.getParameter("cgId"));
			int userId = Integer.parseInt(request.getParameter("userId"));
			String cgName = request.getParameter("category_name");
			Category cg = cgService.getByName(cgName, userId);
			
			if (null == cg) {//允许更新该分类
				int res = cgService.updateCategory(cgId, cgName);				
				if (res > 0) {
					request.getSession().setAttribute("succUpdateMsg", "更新分类成功！");
					response.sendRedirect("category?action=manage&userId="+userId);
				} else {
					request.getSession().setAttribute("errorUpdateMsg", "更新分类失败！");
					response.sendRedirect("category?action=manage&userId="+userId);
				}				
			} else {//该分类已存在，不允许更新该分类
				if (cgId != cg.getId()) {//查询的id和cgId不能一样
					request.getSession().setAttribute("errorUpdateMsg", "该分类名已存在，请重新填写！");
				}				
				response.sendRedirect("category?action=edit&cgId="+cgId);
			}
		}else if(action.equals("delete")){//删除个人文章分类
			int cgId = Integer.parseInt(request.getParameter("cgId"));
			int userId = Integer.parseInt(request.getParameter("userId"));
			int res = cgService.deleteCategory(cgId);
			
			if (res > 0) {	//删除成功
				request.getSession().setAttribute("succDeleMsg", "删除分类成功！");
			} else {
				request.getSession().setAttribute("errorDeleMsg", "删除分类失败！");
			}
			
			response.sendRedirect("category?action=manage&userId="+userId);
		}
	}

}
