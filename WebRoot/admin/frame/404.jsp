<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<jsp:include page="Header.jsp"></jsp:include>

<body>
	<div class="container">
	  <div class="row">
	    <div class="span12">
	      <div class="hero-unit center">
	          <h1>页面没有找到 <small><font face="Tahoma" color="red">错误 404</font></small></h1>
	          <br />
	          <p>您访问的页面没有找到, 请您联系网络管理员或再次尝试. 使用浏览器的 <b>后退</b> 按钮将回到你进入之前的初始页面</p>
	          <p><b>或者您可以按以下按钮:</b></p>
	          <a href="<%=basePath %>index.html" class="btn btn-large btn-info"><i class="icon-home icon-white"></i> 返回首页</a>
	      </div>
	      <br/>

	    </div>
	  </div>
	</div>

<jsp:include page="Footer.jsp"></jsp:include>