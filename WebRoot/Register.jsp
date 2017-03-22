<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--注册页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
String succMsg = (String)request.getSession().getAttribute("succMsg");//注册成功
String errorMsg = (String)request.getSession().getAttribute("errorMsg");//注册失败
String existMsg = (String)request.getSession().getAttribute("existMsg");//用户名或邮箱已被注册
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
					<li><a href="<%=basePath %>index.html">网站首页</a></li>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<li><a href="Login.jsp" target="_blank">登录</a></li>
					<li><a href="Register.jsp" target="_blank">注册</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<% if (null != succMsg) { %>
	<div class="container">
		<div class="alert alert-success">
			<%=succMsg %>，点击<a href="<%=basePath %>Login.jsp">这里</a>进行登录。
		</div>
	</div>
	<%    request.getSession().removeAttribute("succMsg"); 
       } %>

	<% if (null != errorMsg) { %>
	<div class="container">
		<div class="alert alert-error">
			<%=errorMsg %>
		</div>
	</div>
	<%    request.getSession().removeAttribute("errorMsg"); 
        } %>

	<% if (null != existMsg) { %>
	<div class="container">
		<div class="alert alert-error">
			<%=existMsg %>
		</div>
	</div>
	<%    request.getSession().removeAttribute("existMsg"); 
        } %>

	<div class="container ">
		<div class="row col-md-6">
			<form class="form-horizontal" name="register_form"
				action="user?action=register" method="POST"
				onsubmit="return isValidate(register_form)"><!--客户端验证-->
				<fieldset>
					<div id="legend form-group">
						<legend class="caption">注册</legend>
					</div>
					<div class="form-group">
						<!-- Username -->
						<label for="username">用户名</label>
						<input type="text" id="username" name="username" placeholder="请输入用户名" class="form-control">					
					</div>
					<div class="form-group">
						<!-- E-mail -->
						<label  for="email">E-mail</label>
						<input type="text" id="email" name="email" placeholder="请输入邮箱地址" class="form-control">						
					</div>
					<div class="form-group">
						<!-- Password-->
						<label class="control-label" for="password">密码</label>						
						<input type="password" id="password" name="password" placeholder="请输入密码" class="form-control">
					</div>
					<div class="form-group">
						<!-- Password -->
						<label class="control-label" for="password_confirm">密码（确认）</label>
						<input type="password" id="password_confirm" name="password_confirm" placeholder="请再次输入密码" class="form-control">
					</div>
					
					<div class="form-group">
						<!-- Button -->
					    <button class="btn btn-success">注册</button>	
					</div>
				</fieldset>
			</form>
		</div>
	</div>

	<jsp:include page="frame/Footer.jsp"></jsp:include>

	<script type="text/javascript">
	/*客户端验证*/
	function isValidate(form) {
		var username = form.username.value;
		var email = form.email.value;
		var password = form.password.value;
		var password_confirm = form.password_confirm.value;
		
		if (username == "" || email == "" || password == "" || password_confirm == "") {
			alert("用户名、邮箱、密码、确认密码为必填项！");		
			return false;
			
		} else if (password != password_confirm){
			alert("密码和密码（确认）必须相同！");
			return false;
			
		} else {
			return true;
		}		
	}
</script>