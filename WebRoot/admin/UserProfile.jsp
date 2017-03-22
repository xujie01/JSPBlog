<%@ page language="java" import="java.util.*" import="cap.bean.*" pageEncoding="UTF-8"%>
<!--用户详细信息-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
Admin admin = (Admin)request.getSession().getAttribute("admin");//用户资料
Profile pf = (Profile)request.getAttribute("pf");//用户详细信息
%>

<jsp:include page="frame/Header.jsp"></jsp:include>

	<% if (null != admin) { %>
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
            <li class="active"><a href="<%=basePath %>admin.html?action=useradmin"><i class="glyphicon glyphicon-cog"></i> 用户管理</a></li>
            <li><a href="<%=basePath %>admin.html?action=SysArticalAdmin"><i class="glyphicon glyphicon-cog"></i> 文章管理</a></li>
            <li><a href="<%=basePath %>admin.html?action=SysCategoryAdmin"><i class="glyphicon glyphicon-cog"></i> 分类管理</a></li>
            
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
        </div><!-- /.navbar-collapse -->
      </nav>
      
      
      <div id="page-wrapper">
        <div class="row">
          <div class="col-md-12">
            <h1>轻博客系统 <small>基于Bootstrap、Jsp和Servlet技术构建</small></h1>
            <ol class="breadcrumb">
              <li><a href="<%=basePath%>admin/index.jsp"><i class="icon-dashboard"></i> 控制面板</a></li>
              <li><a href="<%=basePath%>admin.html?action=useradmin"><i class="icon-bar-chart"></i> 用户管理</a></li>
              <li class="active"> 用户详细信息</li>
            </ol>
          </div>
        </div> 
        
        <div class="row">
       	<div class="col-md-12">
         	<div class="table-responsive">
           	<table class="table table-hover tablesorter">
			<thead>
				<tr>
					<th>姓</th>
          			<th>名</th>
          			<th>性别</th>
          			<th>联系电话</th>
         			</tr>
         			
         		</thead>
         		<tbody>
         			<tr>
         				<th>
         					<%=pf.getFirstName() %>
         				</th>
         				<th>
         					<%=pf.getLastName() %>
         				</th>
         				<th>
         					<% if (pf.getGender() == 1) { %>  
          				男
          				<% } else { %>
          				女
          				<% }  %>
         				</th>
         				<th>
         					<%=pf.getTelephone() %>
         				</th>
         			</tr>
         		</tbody>
         	</table>
			</div>
         </div>
        </div><!-- /.row -->
      </div><!-- /#page-wrapper -->
<% } else { %>
<%-- 404 page --%>
<jsp:include page="frame/404.jsp"></jsp:include>
<% } %>
<jsp:include page="frame/Footer.jsp"></jsp:include>
            
            