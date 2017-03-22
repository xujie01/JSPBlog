<%@ page language="java" import="java.util.*" import="cap.bean.*" import="cap.dao.*" pageEncoding="UTF-8"%>
<!--文章管理页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
Admin admin = (Admin)request.getSession().getAttribute("admin");//管理员信息
List<Article> artList = (List<Article>)request.getAttribute("artList");//文章列表
String deleSuccMsg = (String)request.getSession().getAttribute("deleSuccMsg");	//删除文章消息
String deleErrorMsg = (String)request.getSession().getAttribute("deleErrorMsg");

int curPage = (Integer)request.getAttribute("curPage");
int totalPages = (Integer)request.getAttribute("totalPages");
%>

<jsp:include page="frame/Header.jsp"></jsp:include>

<%
	if (null != admin) {
%>
      <div class="container">
	  <!-- Sidebar -->
      <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
          <a class="navbar-brand" href="<%=basePath %>admin.html?action=index">轻博客管理系统</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav side-nav">
            <li><a href="<%=basePath %>admin.html?action=index"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
            <li><a href="<%=basePath%>admin.html?action=useradmin"><i class="glyphicon glyphicon-cog"></i> 用户管理</a></li>
            <li  class="active"><a href="<%=basePath%>admin.html?action=SysArticalAdmin"><i class="glyphicon glyphicon-cog"></i> 文章管理</a></li>
            <li><a href="<%=basePath%>admin.html?action=SysCategoryAdmin"><i class="glyphicon glyphicon-edit"></i> 分类管理</a></li>
            
          </ul>

          <ul class="nav navbar-nav navbar-right navbar-user">
            <li class="dropdown user-dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> <%=admin.getUserName()%> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 设置</a></li>
                <li class="divider"></li>
                <li><a href="<%=basePath%>admin.html?action=logout"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </nav>
    

	<div id="page-wrapper">

       <div class="row">
         <div class="col-md-12">
           <br>
           <ol class="breadcrumb">
           <li><a href="<%=basePath%>admin/index.jsp"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
             <li class="active"><i class="glyphicon glyphicon-edit"></i> 文章管理</li>
           </ol>
         </div>  
       </div>
       
		<%
       	if (null != deleSuccMsg) {
       	%>
	  	<div class="row">
         	<div class="col-md-12">
	  		<div class="alert alert-success"><%=deleSuccMsg%></div>
	  		</div>
	  	</div>
	  	<%
	  		request.getSession().removeAttribute("deleSuccMsg");
	  	}
	  	%>
	  	
	  	<%
	  	if (null != deleErrorMsg) {
	  	%>
	  	<div class="row">
         	<div class="col-md-12">
	  		<div class="alert alert-error"><%=deleErrorMsg%></div>
	  		</div>
	  	</div>
	  	<%
	  		request.getSession().removeAttribute("deleErrorMsg"); 
	  	}
	  	%>			

        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table class="table table-hover tablesorter">
                <thead>
                  <tr>
                    <th>文章标题 </th>
                    <th>作者</th>
                    <th>发布时间</th>
                    <th style="width: 50px;">操作 </th>
                  </tr>
                </thead>
           
                <tbody>
				<%
					if ((artList != null) && (artList.size() > 0)) {
							for (Article art : artList) {
								if (0 == art.getIsDelete()) {
									String deleUrl = basePath
											+ "admin.html?action=DeleteSysArtical&artId="
											+ art.getId();
									//UserDaoImpl uDao = new UserDaoImpl();
									//User u = uDao.getUserById(art.getUserId());
				%>
				<tr>
                    <td>
                    <a href="<%=basePath%>comment.html?action=post&artId=<%=art.getId() %>&userId=<%=art.getUserId() %>" target="_blank">
                    <%=art.getTitle() %></a></td>
                    <td><%=art.getUsername() %></td>
                    <td><%=art.getPublishTime() %></td>
                    <td>
		              <a onClick="dele('<%=deleUrl %>')"><i class="glyphicon glyphicon-floppy-remove"></i></a>
                    </td>
                  </tr>
     		    
     		    <%          }  
     		            }
     		        } else { %>
     		    <%="获取系统分类失败！" %>
     		    <% } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        
        <!-- pager -->
          <ul class="pager">
          	<% if (curPage > 1) { %>
            <li class="previous"><a href="<%=basePath%>admin.html?action=SysArticalAdmin&curPage=<%=(curPage-1)%>">&larr; 上一页</a></li>
            <% } %>
            
            <% if (curPage < totalPages) { %>
            <li class="next"><a href="<%=basePath%>admin.html?action=SysArticalAdmin&curPage=<%=(curPage+1)%>">下一页  &rarr;</a></li>
            <% } %>
          </ul>
        
		</div>
    </div>
    
<% } else { %>
<%-- 404 page --%>
<jsp:include page="frame/404.jsp"></jsp:include>
<% } %>
<jsp:include page="frame/Footer.jsp"></jsp:include>

<script type="text/javascript">
function dele(deleUrl) {	
	if (confirm("你确定要删除该分类吗？")) {
		location.href = deleUrl;	
	}
}
</script>