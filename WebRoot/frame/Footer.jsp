<%@ page language="java" import="java.util.*" import="cap.bean.*" import="cap.dao.impl.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <div class="container">
      <hr>      
      <footer>
        <div class="row">
          <div class="col-lg-12">
            <p >
            Copyright &copy; 2017 &middot; UI based on Bootstrap 3.3.7 
                                  &middot; <a href="<%=basePath %>AdminLogin.jsp" target="_blank">管理员</a>
                                  &middot; 598666564@qq.com 
                                  &middot;访问人数：<%=(Integer)session.getAttribute("num") %>                           
                            
            </p>
          </div>
        </div>
      </footer>
    </div>
  
    <script src="<%=basePath %>bootstrap/js/bootstrap.js"></script>
    
  </body>
</html>
