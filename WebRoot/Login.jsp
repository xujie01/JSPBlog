<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--登陆页面-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
String errorMsg = (String)request.getSession().getAttribute("msg");//登录验证失败提示信息
String userIsDeleMsg = (String)request.getSession().getAttribute("userIsDeleMsg");//用户被禁用提示信息
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

       <!--导航链接，表格，和切换其他内容-->
       <div class="collapse navbar-collapse navbar-ex1-collapse">
         <ul class="nav navbar-nav">
           <li><a href="<%=basePath %>index.html">网站首页</a></li>
         </ul>
       
         <ul class="nav navbar-nav navbar-right">
         	<li><a href="Login.jsp" target="_blank">登录</a></li>
         	<li><a href="Register.jsp" target="_blank">注册</a></li>
         </ul>        
       </div><!-- /.navbar-collapse -->
     </div><!-- /.container -->
   </nav>
			    
    <% if (null != errorMsg) { %>		<%-- 登录验证失败提示信息 --%>
    <div class="container">
    <div class="alert alert-error"><!--Glyphicons字体图标错误消息-->
    <%=errorMsg %>
    </div>
    </div>
    <%    
    	request.getSession().removeAttribute("msg");
    } 
    %>
				    
    <% if (null != userIsDeleMsg) { %>   <%-- 用户被禁用提示信息 --%>
    <div class="container">
    <div class="alert alert-error">
    <%=userIsDeleMsg %>
    </div></div>
    <%
    	request.getSession().removeAttribute("userIsDeleMsg");
    } 
    %>

	<div class="container">
		<div class="row col-md-6"><!--中等屏幕（桌面显示器，大于等于 992px）-->
			<form name="login_form" role="form" action="user?action=login"
				method="POST" onsubmit="return isValidate(login_form)"><!--客户端验证-->
				<fieldset>
					<div id="legend">
						<legend class="caption">登录</legend>
					</div>
					<div class="form-group">
						<label for="username">用户名</label> 
						<input type="text"
							class="form-control " name="username" id="username"
							placeholder="请输入用户名">
					</div>
					<div class="form-group">
						<label for="password">密码</label> <input type="password"
							class="form-control" name="password" id="password"
							placeholder="输入密码">
					</div>					
					<div class="form-group">
					<button type="submit" class="btn btn-success">登录</button>
					</div>
				</fieldset>
			</form>
		</div>
	</div>

	<jsp:include page="frame/Footer.jsp"></jsp:include>

<script type="text/javascript">
/*客户端验证 */
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
