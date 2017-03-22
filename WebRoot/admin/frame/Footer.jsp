<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <script src="<%=basePath %>bootstrap/js/jquery-2.1.1.js"></script>
    <script src="<%=basePath %>bootstrap/js/bootstrap.js"></script>
  </body>
</html>
