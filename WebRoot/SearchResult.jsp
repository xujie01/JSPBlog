<%@ page language="java" import="java.util.*" import="java.text.*"
import="cap.bean.*"
pageEncoding="utf-8"%>
<!--搜索文章结果页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");//用户信息
List<Article> artList = (List<Article>)request.getAttribute("artList");//文章结果列表
String q = (String)request.getAttribute("q");
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

        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav">
            <li><a href="<%=basePath%>index.html">网站首页</a></li>
          </ul>
          
          <%
          	if (null != u) {
          %>
          <ul class="nav navbar-nav">
            <li><a href="<%=basePath%>user?action=myblog&userId=<%=u.getId()%>">我的博客</a></li>
          </ul>
          
          <ul class="nav navbar-nav">
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">博客管理<b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%=basePath%>article?action=manage&userId=<%=u.getId()%>"><i class="icon-cog"></i> 博文管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath%>category?action=manage&userId=<%=u.getId()%>"><i class="icon-cog"></i> 分类管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath%>comment.html?action=manage&userId=<%=u.getId()%>"><i class="icon-cog"></i> 评论管理</a></li>
                </ul>
            </li>
          </ul>
          <%
          	}
          %>
          
          <%
          	if (null == u) {
          %>
          <ul class="nav navbar-nav navbar-right">
          	<li><a href="Login.jsp" target="_blank">登录</a></li>
          	<li><a href="Register.jsp" target="_blank">注册</a></li>
          </ul>
          <%
          	} else {
          %>
          <div class="pull-right">
                <ul class="nav pull-right">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎，<%=u.getUserName()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=basePath%>user?action=profile&id=<%=u.getId()%>"><i class="icon-cog"></i> 编辑个人信息</a></li>
                            <%
                            	if (u.getIsApplied() == 1) {
                            %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath%>user?action=bloginfo&userId=<%=u.getId()%>"><i class="icon-cog"></i> 编辑博客信息</a></li>
                            <%
                            	}
                            %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath%>user?action=logout"><i class="icon-off"></i> 登出</a></li>
                        </ul>
                    </li>
                </ul>
          </div>
          <%
          	}
          %>
          
        </div>
      </div>
    </nav>

    <div class="container">

      <div class="row">
        <div class="col-md-8">

          <p class="lead">
			搜索关键字：<b><i>
			<%
				if (null != q) {
			%>
				<%=q%>
			<%
				} else {
			%>
				<%="没有输入搜索内容"%>
			<%
				}
			%></i></b>
          </p>
          <hr>
          <p class="lead">
          	搜索结果列表：
          </p>
          
          <%
          if ((null != artList) && (artList.size() > 0)) { 
              for (Article art : artList) {
                   if (0 == art.getIsDelete()) {	//删除的文章就不显示了
         %>
 		  <h4>
 		  <a href="<%=basePath%>comment.html?action=post&artId=<%=art.getId()%>&userId=<%=art.getUserId() %>" target="_blank"><%=art.getTitle() %></a>
 		  </h4>        	
          <%	  }	
              }
          } else { %>
          <p>Sorry，未找到相关文章~</p>
          <% } %>
        </div>
      </div>
    </div>
    
<jsp:include page="frame/Footer.jsp"></jsp:include>
