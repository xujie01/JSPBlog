<%@ page language="java" import="java.util.*" import="cap.bean.*" 
import="cap.dao.*" pageEncoding="UTF-8"%>
<!--评论管理页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");
Boolean notFound = (Boolean)request.getAttribute("notFound");
//添加下面两行代码用于分页显示
int curPage = (Integer)request.getAttribute("curPage");
int totalPages = (Integer)request.getAttribute("totalPages");

/*List<List<Comment>> cmtListList = (List<List<Comment>>)request.getAttribute("cmtListList");*/
List<Ucomment> cmtList=(List<Ucomment>)request.getAttribute("cmtList");
String succDeleMsg = (String)request.getSession().getAttribute("succDeleMsg");
String errorDeleMsg = (String)request.getSession().getAttribute("errorDeleMsg");

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
                    <li><a href="<%=basePath %>article?action=manage&userId=<%=u.getId() %>"><i class="glyphicon glyphicon-cog"></i> 博文管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath %>category?action=manage&userId=<%=u.getId() %>"><i class="glyphicon glyphicon-cog"></i> 分类管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath %>comment.html?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 评论管理</a></li>
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
                            <li><a href="<%=basePath %>user?action=profile&id=<%=u.getId() %>"><i class="glyphicon glyphicon-cog"></i> 编辑个人信息</a></li>
                            <% if (u.getIsApplied() == 1) { %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath %>user?action=bloginfo&userId=<%=u.getId() %>"><i class="glyphicon glyphicon-cog"></i> 编辑博客信息</a></li>
                            <% } %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath %>user?action=logout"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
                        </ul>
                    </li>
                </ul>
          </div>
          <% } %>
          
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>
  	
	<%-- 删除评论的提示消息 --%>
	<% if (null != succDeleMsg) { %>
  	<div class="container">
  	<div class="alert alert-success"><%=succDeleMsg %></div>
  	</div>
  	<% 
  	       request.getSession().removeAttribute("succDeleMsg");
  	   } 
  	%>
  	
  	<% if (null != errorDeleMsg) { %>
  	<div class="container">
  	<div class="alert alert-error"><%=errorDeleMsg %></div>
  	</div>
  	<%     
  	       request.getSession().removeAttribute("errorDeleMsg"); 
  	   } 
  	%>
  	
	<% if (null != u) { %>
	<div class="container">	
		<div class="well">
			<table class="table">
				<thead>
					<tr>
						<th>评论内容</th>
						<th>评论人</th>
						<th>评论的文章标题</th>

						<th>评论时间</th>
						<th style="width: 50px;">操作</th>
					</tr>
				</thead>
				<tbody>
					<% 
		      		if ((null != cmtList) && (cmtList.size() > 0)) { 
		      			
		      				for (Ucomment cmt : cmtList) {
		      					
	      							String deleUrl = basePath + "comment.html?action=delete&cmtId=" + cmt.getCid() + "&userId=" + u.getId(); //删除链接
		      	%>
					<tr>
						<td><%=cmt.getCcontent() %></td>
						<td><%=cmt.getUsername() %></td>
						<td><%=cmt.getTitle() %></td>


						<td><%=cmt.getPublish_time() %></td>
						<td><a onClick="dele('<%=deleUrl %>')"><i
								class="glyphicon glyphicon-remove"></i></a></td>
					</tr>
					<% } 
		      		}%>
				</tbody>
			</table>
		</div>
		
		
		<div>
		 <!-- pager -->
          <ul class="pager">
          	<% if (curPage > 1) { %>
            <li class="previous"><a href="<%=basePath%>comment.html?action=manage&userId=<%=u.getId()%>&curPage=<%=(curPage-1)%>">&larr; 上一页</a></li>
            <% } %>
            
            <% if (curPage < totalPages) { %>
            <li class="next"><a href="<%=basePath%>comment.html?action=manage&userId=<%=u.getId() %>&curPage=<%=(curPage+1)%>">下一页  &rarr;</a></li>
            <% } %>
          </ul>
		</div>
		
	</div>	<!-- /container -->		
	<%} %>
	
<jsp:include page="frame/Footer.jsp"></jsp:include>

<script type="text/javascript">
function dele(deleUrl) {	
	if (confirm("你确定要删除该评论吗？")) {
		location.href = deleUrl;
	}
}
</script>