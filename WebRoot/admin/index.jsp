<%@ page language="java" import="java.util.*" import="cap.bean.*" import="cap.dao.impl.*" pageEncoding="UTF-8"%>
<!--管理员界面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	Admin admin = (Admin) request.getSession().getAttribute("admin");//管理员信息
	List<Article> artList=(List<Article>)request.getAttribute("artList");//所有文章
	List<Comment> cmtList=(List<Comment>)request.getAttribute("cmtList");//所有评论
	List<User> uList=(List<User>)request.getAttribute("uList");//所有用户
	Counter cnt=(Counter)request.getAttribute("cnt");//网站来访数	
%>

<jsp:include page="frame/Header.jsp"></jsp:include>

<% if (null != admin) { %>
      <div class="container">
      <div class="col-md-12">
      <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
       
        <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
          <a class="navbar-brand" href="<%=basePath%>admin.html?action=index">轻博客管理系统</a>
        </div>

        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav side-nav">
            <li class="active"><a href="<%=basePath %>admin.html?action=index"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
            <li><a href="<%=basePath %>admin.html?action=useradmin"><i class="glyphicon glyphicon-cog"></i> 用户管理</a></li>
            <li><a href="<%=basePath %>admin.html?action=SysArticalAdmin"><i class="glyphicon glyphicon-cog"></i> 文章管理</a></li>
            <li><a href="<%=basePath %>admin.html?action=SysCategoryAdmin"><i class="glyphicon glyphicon-edit"></i> 分类管理</a></li>
            
          </ul>

          <ul class="nav navbar-nav navbar-right navbar-user">
            <li class="dropdown user-dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> <%=admin.getUserName() %> <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 设置</a></li>
                <li class="divider"></li>
                <li><a href="<%=basePath%>admin.html?action=logout"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </nav>
     </div>
     
	<div id="page-wrapper">

        <div class="row">
          <div class="col-md-12">
            <h1>轻博客系统 <small>基于Bootstrap、Jsp和Servlet技术构建</small></h1>
            <ol class="breadcrumb">
              <li class="active"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</li>
            </ol>
            
          <div class="row">
	        <div class="col-md-3">
	            <div class="panel panel-info">
	              <div class="panel-heading">
	                <div class="row">
	                  <div class="col-xs-6">
	                    <i class="glyphicon glyphicon-search"></i>
	                  </div>
	                  <div class="col-xs-6 text-right">
	                    <p class="announcement-heading"><%=cnt.getCount() %></p>
	                    <p class="announcement-text">来访人数</p>
	                  </div>
	                </div>
	              </div>
	            </div>
            </div>
            
            <div class="col-md-3" >
	            <div class="panel panel-success">
	              <div class="panel-heading">
	                <div class="row">
	                  <div class="col-xs-6">
	                    <i class="glyphicon glyphicon-edit"></i>
	                  </div>
	                  <div class="col-xs-6 text-right">
	                    <p class="announcement-heading"><%=artList.size() %></p>
	                    <p class="announcement-text">文章总数</p>
	                  </div>
	                </div>
	              </div>
	            </div>
            </div>
            
            <div class="col-md-3">
            <div class="panel panel-warning">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="glyphicon glyphicon-envelope"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading"><%=cmtList.size() %></p>
                    <p class="announcement-text">评论总数</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
            
            
            <div class="col-md-3">
            <div class="panel panel-danger">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
             		  <i class="glyphicon glyphicon-user"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading"><%=uList.size() %></p>
                    <p class="announcement-text">注册会员数</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
                      
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