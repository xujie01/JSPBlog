<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--管理员登陆页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
String errorMsg = (String)request.getSession().getAttribute("msg");//登录验证失败提示
String logoutMsg = (String)request.getSession().getAttribute("logoutMsg");//退出成功提示
%>
<jsp:include page="frame/Header.jsp"></jsp:include>

<body>

	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
     <div class="container">
       <div class="navbar-header">
         <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
           <span class="sr-only">Toggle navigation</span>
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
           <span class="icon-bar"></span>
         </button>
         <a class="navbar-brand" href="index.html">轻博客</a>
       </div>

       <!-- Collect the nav links, forms, and other content for toggling -->
       <div class="collapse navbar-collapse navbar-ex1-collapse">
         <ul class="nav navbar-nav">
           <li><a href="<%=basePath %>index.html" target="_blank">访问网站首页</a></li>
         </ul>        
       </div><!-- /.navbar-collapse -->
     </div><!-- /.container -->
   </nav>

	<% if (null != errorMsg) { %>		<%-- 登录验证失败提示 --%>
	<div class="container">
    <div class="alert alert-error">
    <%=errorMsg %>
    </div></div>
    <%    request.getSession().removeAttribute("msg");
    } %>
    
    <% if (null != logoutMsg) { %>		<%-- 退出成功提示 --%>
	<div class="container">
    <div class="alert alert-success">
    <%=logoutMsg %>
    </div></div>
    <%    request.getSession().removeAttribute("logoutMsg");
    } %>

   <div class="container">
    <div class="row">
		<div class="col-md-6">
			<form name="login_form" class="form-horizontal" action='admin.html?action=login' method="POST" onsubmit="return isValidate(login_form)">
			  <fieldset>
			    <div id="legend">
			      <legend class="caption">管理员登录</legend>
			    </div>
			 
			    <div class="form-group">
			      <!-- Username -->
			      <label for="username">用户名</label>
                   <input class="form-control" type="text" id="username" name="username" placeholder="请输入用户名" >
			    </div>
			    <div class="form-group">
			      <!-- Password-->
			      <label  for="password">密码</label>		      
			        <input class="form-control" type="password" id="password" name="password" placeholder="请输入密码" >
			    </div>
			    <div class="form-group">
			      <!-- Button -->		     
			        <button class="btn btn-success">登录</button>
			    </div>
			  </fieldset>
			</form>
		</div>
	</div>
</div>

<jsp:include page="frame/Footer.jsp"></jsp:include>

<script type="text/javascript">
function isValidate(login_form) {
	var username = login_form.username.value;
	var password = login_form.password.value;
	
	if (username == "" || password == "") {
		alert("请填写用户名和密码！");	
		
		return false;
	}
	return true;
}
</script>
