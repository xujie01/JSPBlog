<%@ page language="java" import="java.util.*" import="cap.bean.*" pageEncoding="UTF-8"%>
<!--新建分类页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
Admin admin = (Admin)request.getSession().getAttribute("admin");//管理员信息
String scgExist = (String)request.getSession().getAttribute("scgExist");//添加失败信息
%>

<jsp:include page="frame/Header.jsp"></jsp:include>

	<% if (null != admin) { %>
      <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
          <a class="navbar-brand" href="<%=basePath %>admin.html?action=index">轻博客管理系统</a>
        </div>
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav side-nav">
            <li><a href="<%=basePath %>admin.html?action=index"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
            <li><a href="<%=basePath %>admin.html?action=useradmin"><i class="glyphicon glyphicon-cog"></i> 用户管理</a></li>
            <li><a href="<%=basePath %>admin.html?action=SysArticalAdmin"><i class="glyphicon glyphicon-cog"></i> 文章管理</a></li>
            <li class="active"><a href="<%=basePath %>admin.html?action=SysCategoryAdmin"><i class="glyphicon glyphicon-edit"></i> 分类管理</a></li>
            
          </ul>

          <ul class="nav navbar-nav navbar-right navbar-user">
            <li class="dropdown user-dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> <%=admin.getUserName() %> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#"><i class="icon-gear"></i> 设置</a></li>
                <li class="divider"></li>
                <li><a href="<%=basePath%>admin.html?action=logout"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </nav>
      
     
	<div id="page-wrapper">
        <div class="row">
          <div class="col-md-12">
              <h1>轻博客系统 <small>基于Bootstrap、JSP和Servlet技术构建</small></h1>
              <ol class="breadcrumb">
	              <li><a href="<%=basePath%>admin/index.jsp"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
	              <li><a href="<%=basePath %>admin.html?action=SysCategoryAdmin"><i class="glyphicon glyphicon-cog"></i> 分类管理</a></li>
	              <li class="active"><i class="glyphicon glyphicon-cog"></i> 新建分类</li>
              </ol>

			  <% if (null != scgExist) { %>	<%-- 添加失败 --%>
		  	  <div class="row">
         	  <div class="col-md-12">
		  		  <div class="alert alert-warning"><%=scgExist %></div>
		  	  </div>
		  	  </div>
		  	  <%     
		  	          request.getSession().removeAttribute("scgExist"); 
		  	   } 
		  	  %>
	          <div class="row">
	          	<div class="col-md-6">
	          		<form action="<%=basePath %>admin.html?action=AddSysCategory" method="post">
	            		<label>分类名：</label><input name="scgName" class="form-control" type="text"/><br>
	            		<input type="submit" class="btn btn-primary" value="保存">
	            	</form>
				</div>
			  </div>
		  </div>
        </div>
    </div>

<% } else { %>
<%-- 404 page --%>
<jsp:include page="frame/404.jsp"></jsp:include>
<% } %>
<jsp:include page="frame/Footer.jsp"></jsp:include>

