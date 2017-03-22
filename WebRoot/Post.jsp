<%@ page language="java" import="java.util.*" import="cap.bean.*"
	import="cap.dao.impl.*" pageEncoding="UTF-8"%>
<!--博文详情页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
int userId = 0;
User u = (User)request.getSession().getAttribute("user");//用户登录后的信息
Article art = (Article)request.getAttribute("art");//博文信息
SysCategory scg = (SysCategory)request.getAttribute("scg");//系统分类信息
Category cg = (Category)request.getAttribute("cg");//个人分类信息
String author = (String)request.getAttribute("author");//作者

String succMsg = (String)request.getSession().getAttribute("succMsg");//评论成功
String errorMsg = (String)request.getSession().getAttribute("errorMsg");//评论失败
List<Comment> cmtList = (List<Comment>)request.getAttribute("cmtList");//博文评论列表
List<Article> artList = (List<Article>)request.getAttribute("artList");//相关文章列表
%>

<jsp:include page="frame/Header.jsp"></jsp:include>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html">轻博客</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.html">网站首页</a></li>
				</ul>

				<%
					if ((null != u) && (u.getIsApplied() == 1)) {
				%>
				<ul class="nav navbar-nav">
					<li><a
						href="<%=basePath%>user?action=myblog&userId=<%=u.getId()%>">我的博客</a></li>
				</ul>

				<ul class="nav navbar-nav">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">博客管理<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a
								href="<%=basePath%>article?action=manage&userId=<%=u.getId()%>"><i
									class="icon-cog"></i> 博文管理</a></li>
							<li class="divider"></li>
							<li><a
								href="<%=basePath%>category?action=manage&userId=<%=u.getId()%>"><i
									class="icon-cog"></i> 分类管理</a></li>
							<li class="divider"></li>
							<li><a
								href="<%=basePath%>comment.html?action=manage&userId=<%=u.getId()%>"><i
									class="icon-cog"></i> 评论管理</a></li>
						</ul></li>
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
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">欢迎，<%=u.getUserName()%> <b
								class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="<%=basePath%>user?action=profile&id=<%=u.getId()%>"><i
										class="icon-cog"></i> 编辑个人信息</a></li>
								<%
									if (u.getIsApplied() == 1) {
								%>
								<li class="divider"></li>
								<li><a
									href="<%=basePath%>user?action=bloginfo&userId=<%=u.getId()%>"><i
										class="icon-cog"></i> 编辑博客信息</a></li>
								<%
									}
								%>
								<li class="divider"></li>
								<li><a href="<%=basePath%>user?action=logout"><i
										class="icon-off"></i> 登出</a></li>
							</ul></li>
					</ul>
				</div>
				<%
					}
				%>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<!-- the actual blog post: title/author/date/content -->
				<%
					if (null != art) {
				%>
				<h2><%=art.getTitle()%></h2><!--博文标题-->
				<p>
					<i class="icon-user"></i> <a href="<%=basePath%>user?action=myblog&userId=<%=art.getUserId()%>" target="_blank"> <%=author%></a> | <i
						class="icon-calendar"></i><!--博文标题、发布时间-->
					<%=art.getPublishTime()%>
					| 阅读
					<%=art.getCount()%>
					次
				</p>
				<hr>
				<span><%=art.getContent().replaceAll("\\r\\n","<br>")%></span>
				<%
					} else {
				%>
				读取文章内容出错，你可以尝试重新刷新页面哦~
				<%
					}
				%>
				<hr>

				<!-- the comment box -->
				<div class="well">
					<%
						if (null != succMsg) {
					%>
					<div class="alert alert-success"><%=succMsg%></div>
					<%
						request.getSession().removeAttribute("succMsg");
					    }
					%>
					<%
						if (null != errorMsg) {
					%>
					<div class="alert alert-error"><%=errorMsg%></div>
					<%
						request.getSession().removeAttribute("errorMsg"); 
					    }
					%>
					<h4>评论：</h4>

					<%
						if (null != u) {
					       userId = u.getId();
					    }
					%>
					<form role="form" name="comment"
						action="comment.html?action=commit&userId=<%=userId%>&artId=<%=art.getId()%>"
						method="post" onsubmit="return isValidate(comment)">
						<div class="form-group">
							<textarea class="form-control" rows="3" name="comment_content"></textarea>
						</div>
						<button type="submit" class="btn btn-primary">提交</button>
					</form>
				</div>

				<div class="well">
					<h4>相关文章列表：</h4>
					<%
					if (artList != null) { 
					    for (Article relateArt : artList) {
					%>
					<ul>
						<li><a
							href="comment.html?action=post&artId=<%=relateArt.getId() %>&userId=<%=relateArt.getUserId() %>"
							target="_blank"><%=relateArt.getTitle() %></a></li>
					</ul>
					<% 
		           		}
		            } 
		          	%>
				</div>

				<hr>
				<!-- the comments -->
				<%
				if (null != cmtList) { 
				    for (Comment cmt : cmtList) { 
				         if (cmt.getIsDelete() == 0) {	//未被删除的评论
					         int cmtUserId = cmt.getUserId();
					          UserDaoImpl uDao = new UserDaoImpl();
					          User cmtUser = uDao.getUserById(cmtUserId);
				%>
				<p>
					<i class="icon-user"></i><a
						href="<%=basePath %>user?action=myblog&userId=<%=cmt.getUserId() %>" target="_blank">
						<%=cmtUser.getUserName() %></a> | <i class="icon-calendar"></i>
					<%=cmt.getTime() %>
				</p>
				<p><%=cmt.getContent() %></p>

				<hr>
				<%   
          			} 
                }
             } else { %>
				暂无评论。。。
				<% } %>
			</div>

			<div class="col-md-4">
				<div class="well">
					<h4>所属系统分类</h4>
					<div class="row">
						<div class="col-md-6">
							<ul class="list-unstyled">
								<% if (null != scg) { %>
								<li><%=scg.getCategoryName() %></li>
								<% } %>
							</ul>
						</div>
					</div>
				</div>
				<!-- /well -->

				<div class="well">
					<h4>所属个人分类</h4>
					<div class="row">
						<div class="col-lg-6">
							<ul class="list-unstyled">
								<% if ((null != cg) && (cg.getIsDelete() == 0)) { %>
								<li><%=cg.getCategoryName() %></li>
								<% } else { %>
								<li>无分类</li>
								<% } %>
							</ul>
						</div>
					</div>
				</div>
				<!-- /well -->
			</div>
		</div>

		<jsp:include page="frame/Footer.jsp"></jsp:include>

		<script type="text/javascript">
			function isValidate(comment) {
				var comment_content = comment.comment_content.value;
				if (comment_content == "") {
					alert("请填写评论内容");
					return false;
				}
				return true;
			}
		</script>