<%@ page language="java" import="java.util.*" import="cap.bean.*" 
import="cap.dao.*" pageEncoding="UTF-8"%>
<!--新建文章-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");//用户资料
List<Category> cgList = (List<Category>)request.getAttribute("cgList");//个人分类信息
List<SysCategory> scgList = (List<SysCategory>)request.getAttribute("scgList");//系统分类信息
%>

<jsp:include page="frame/Header.jsp"></jsp:include>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
          <a class="navbar-brand" href="index.html">轻博客</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav">
            <li><a href="index.html">首页</a></li>
          </ul>
          
          <% if (null != u) { %>
          <ul class="nav navbar-nav">
            <li><a href="<%=basePath %>user?action=myblog&userId=<%=u.getId() %>">我的博客</a></li>
          </ul>
          
          <ul class="nav navbar-nav">
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">博客管理<b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%=basePath %>article?action=manage&userId=<%=u.getId() %>"><i class="icon-cog"></i> 博文管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath %>category?action=manage&userId=<%=u.getId() %>"><i class="icon-cog"></i> 分类管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath %>comment.html?action=manage&userId=<%=u.getId()%>"><i class="icon-cog"></i> 评论管理</a></li>
                </ul>
            </li>
          </ul>
          <% } %>
          
          <% if (null == u) { %>
          <ul class="nav navbar-nav navbar-right">
          	<li><a href="Login.jsp" target="_blank">登录</a></li>
          	<li><a href="Register.jsp" target="_blank">注册</a></li>
          </ul>
          <% } else { %>
          <div class="pull-right">
                <ul class="nav pull-right">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎，<%=u.getUserName() %> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=basePath %>user?action=profile&id=<%=u.getId() %>"><i class="icon-cog"></i> 编辑个人信息</a></li>
                            <% if (u.getIsApplied() == 1) { %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath %>user?action=bloginfo&userId=<%=u.getId() %>"><i class="icon-cog"></i> 编辑博客信息</a></li>
                            <% } %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath %>user?action=logout"><i class="icon-off"></i> 登出</a></li>
                        </ul>
                    </li>
                </ul>
          </div>
          <% } %>
          
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>
        
    <% if (null != u) { %>
	<div class="container">
		
		<div class="row col-md-12">
			<div class="col-md-12">
			   <div class="col-md-12">
					<ol class="breadcrumb">
		              <li><a href="<%=basePath%>article?action=manage&userId=<%=u.getId() %>">博文管理</a></li>
		              <li class="active">新建文章</li>
		            </ol>
	            </div>
	            
	            <form class="form-horizontal" name="add_artical_form" action="<%=basePath %>article?action=save&userId=<%=u.getId() %>" method="post">
	                <div class="col-md-6">
	                    <div class="form-group">
	                    <label for="title">标题</label>
	                    <input class="form-control" id="name" name="title" type="text" >
	                    </div>
	                    <div class="form-group">
	                    <label for="sys_category">系统分类</label>
	                        <select class="form-control"  id="subject" name="sys_category">
	                    	<% 
	                    	if ((null != scgList) && (scgList.size() > 0)) { 
	                            for (SysCategory scg : scgList) {
	                    	%>
	                    		<option value="<%=scg.getId() %>" selected=""><%=scg.getCategoryName() %></option>                            	
                            <%  }
                            } else { %>
                                <%="获取系统分类失败" %>
                            <% } %>
                            </select>
                         </div> 
                         <div class="form-group">  
                        <label for="category">个人分类</label>
                        	<select class="form-control" id="subject" name="category">
                            <%
                            if ((null != cgList) && (cgList.size() > 0)) {
                            	for (Category cg : cgList) {
                            		if (cg.getIsDelete() == 0) {
                             %>
	                         <option value="<%=cg.getId() %>" selected=""><%=cg.getCategoryName() %></option>
	                         <%     } 
	                            }
	                         } else { %>
                                <%="无分类" %>
                            <% } %>
                        	</select>
                        </div>
	                
	                <div class="form-group">
	                    <textarea class="form-control" id="message" name="summary"  placeholder="摘要" rows="5"></textarea>
	                </div>
	                
	                <div class="form-group">
	                    <textarea class="form-control" id="message" name="content"  placeholder="文章内容" rows="5"></textarea>
	                </div>
	                  
	                <div class="form-group">
	                    <button id="contact-submit" type="submit" class="btn btn-primary input-medium pull-right">保存</button>
	                </div>
	                </div>
	            </form>
	        </div>
		</div>
	</div>
	<% } %>
	
<jsp:include page="frame/Footer.jsp"></jsp:include>