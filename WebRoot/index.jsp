<%@ page language="java" import="java.util.*" 
import="cap.bean.*" import="cap.dao.impl.*"
pageEncoding="utf-8"%>
<!--首页-->
<%
String path = request.getContextPath();/*返回站点的根路径 */
/*依次返回当前链接使用的协议、应用的根url、端口号 */
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");//用户信息
List<SysCategory> scList = (List<SysCategory>)request.getAttribute("scList");//博文分类信息
List<User> uList = (List<User>)request.getAttribute("uList");//活跃博主信息
List<Article> artList = (List<Article>)request.getAttribute("artList");//当前页码文章信息
List<Article> tenList=(List<Article>)request.getAttribute("tenList");//博文top10
int curPage = (Integer)request.getAttribute("curPage");//当前页码
int totalPages = (Integer)request.getAttribute("totalPages");//总页码
%>

<jsp:include page="frame/Header.jsp"></jsp:include>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation"><!--导航条、反色、固定在顶部 -->
      <div class="container"><!--将导航条居中对齐并在两侧添加内补 -->
        <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index.html">轻博客</a><!--设置了内补（padding）和高度（height） -->
        </div>

        <!--导航链接，表格，和切换其他内容-->
        <div class="collapse navbar-collapse"><!--依赖collapse插件、视口足够窄.navbar-collapse内所包含的内容也将不可见-->
          <ul class="nav navbar-nav"><!--导航、导航项-->
            <li><a href="<%=basePath%>index.html">网站首页</a></li>
          </ul>
          
          <%if ((null != u) && (u.getIsApplied() == 1)) {%>
          <ul class="nav navbar-nav">
            <li><a href="<%=basePath%>user?action=myblog&userId=<%=u.getId()%>">我的博客</a></li>
          </ul>
          
          <ul class="nav navbar-nav">
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">博客管理<b class="caret"></b></a><!--下拉、下拉菜单、下拉菜单项、下拉图标-->
                <ul class="dropdown-menu"><!--下拉菜单-->
                    <li><a href="<%=basePath%>article?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 博文管理</a></li><!--Glyphicons字体图标-->
                    <li class="divider"></li><!--分割线-->
                    <li><a href="<%=basePath%>category?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 分类管理</a></li><!--Glyphicons字体图标-->
                    <li class="divider"></li>
                    <li><a href="<%=basePath%>comment.html?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 评论管理</a></li><!--Glyphicons字体图标-->
                </ul>
            </li>
          </ul>
          <%}%>
          
          <%if (null == u) {%>
          <ul class="nav navbar-nav navbar-right"><!--导航、导航项、居右-->
          	<li><a href="Login.jsp" target="_blank">登录</a></li>
          	<li><a href="Register.jsp" target="_blank">注册</a></li>
          </ul>
          <%} else {%>
          <div class="pull-right"><!--居右-->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎，<%=u.getUserName()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=basePath%>user?action=profile&id=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 编辑个人信息</a></li>
                            <%
                            	if (u.getIsApplied() == 1) {
                            %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath%>user?action=bloginfo&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 编辑博客信息</a></li>
                            <%
                            	}
                            %>
                            <li class="divider"></li>
                            <li><a href="user?action=logout"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
                        </ul>
                    </li>
                </ul>
          </div>
          <%}%>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>

    <div class="container"><!--栅格系统-->
      <div class="row"><!--预定义的类-->
        <div id="blog" class="col-md-8" ><!--中屏幕-->
          <h1><a href="user?action=index">轻博客——<small>基于Bootstrap,JSP,Servlet技术构建</small></a></h1><!--h1标题、small类-->
          <br>          
          <%if ((null != artList) && (artList.size() > 0)){ 
      	 	for (Article art : artList) 
      	 		{//已经过滤删除的文章
   				//UserDaoImpl uDao = new UserDaoImpl();
   				//User user = uDao.getUserById(art.getUserId());   			
   				//ArticleCounter artCnt = artCntDao.getCounter(art.getId());   				
   				if (art != null) {
          %>
 		  <h3><a href="<%=basePath%>comment.html?action=post&artId=<%=art.getId()%>&userId=<%=art.getUserId()%>" target="_blank"><%=art.getTitle()%></a></h3><!--h3标题、博文标题 -->
          <p>
          <i class="glyphicon glyphicon-user"></i> <!--user图标-->
          <a href="<%=basePath%>user?action=myblog&userId=<%=art.getUserId()%>" target="_blank"><%=art.getUsername()%></a><!--作者名--> 
          <%
           		 				}
          %>
		| <i class="glyphicon glyphicon-calendar"></i> <%=art.getPublishTime()%><!--发表时间-->
		| 阅读 <%=art.getCount()%> 次
 		  </p>
          <p><%=art.getSummary()%></p><br><!--博文摘要-->
          <a class="btn btn-primary" href="<%=basePath%>comment.html?action=post&artId=<%=art.getId()%>&userId=<%=art.getUserId()%>">阅读详细 <span class="glyphicon glyphicon-chevron-right"></span></a><!--图标按钮-->             
          <hr>          
          <%
                 }
          } else {
          %>
          <p>还没有写过文章哦，赶紧写吧~</p>
          <%
          }
          %>          
          <!-- 页码 -->
          <ul class="pager"><!--翻页-->
          	<%
          	if (curPage > 1) {
          	%>
            <li class="previous"><a href="<%=basePath%>user?action=index&curPage=<%=(curPage-1)%>">&larr; 上一页</a></li>
            <%
            }
            %>            
            <%
            if (curPage < totalPages) {
            %>
            <li class="next"><a href="<%=basePath%>user?action=index&curPage=<%=(curPage+1)%>">下一页  &rarr;</a></li>
            <%
            }
            %>
          </ul>
        </div>
        
        <div class="col-md-4">
        <%
        if ((u != null) && (u.getIsApplied() == 0)) {
        %>
          <div class="well" align="center">
          	<a class="btn btn-primary" href="<%=basePath%>ApplyBlog.jsp" target="_blank">申请个人博客</a>
          </div>
        <%
        }
        %>        
        <%
        if ((u != null) && (u.getIsApplied() == 1)) {
        %>
          <div class="well" align="center"><!--警告框-->
          	<a class="btn btn-primary" href="<%=basePath%>user?action=myblog&userId=<%=u.getId()%>">进入我的博客</a>
          </div>
        <%
        	}
        %>
        
          <div class="well">
            <h4>搜索站内文章</h4>
            <form name="search_form" action="<%=basePath%>user?action=search" method="post">
            <div class="input-group"><!--输入框组-->
              <input type="text" class="form-control" name="q"><!--输入框-->
              <span class="input-group-btn"><!--任意一侧添加额外元素-->
                <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button><!--搜索按钮-->
              </span>
            </div><!-- /input-group -->
            </form>
          </div><!-- /well -->
          
          <form action="servlet/GetSysCategoryServlet" method="GET">
          <div class="well">
            <h4>网站分类</h4>
              <div class="row">
                <div class="col-md-6">
                  <ul class="list-unstyled"><!--无样式列表-->
                    <%
                   	if ((null != scList) && (scList.size() > 0)) { 
                       	for (SysCategory sc : scList) { 
                       		if (sc.getIsDelete() == 0) {
                    %>
                    <li>
                    <a href="<%=basePath%>index.html?action=indexFilter&sysCategoryId=<%=sc.getId()%>"><%=sc.getCategoryName()%></a>                  
                    </li>
                    <%
                    		}
                        } 
                    } else {
                    %>
                    <li>无分类</li>
                    <%
                    }
                    %>
                  </ul>
                </div>
              </div>
          </div><!-- /well -->
          </form> 
          
          <div class="well">
            <h4>本周活跃博主</h4>
            <div class="row">
                <div class="">
                  <ul class="list-unstyled">
                    <%
                    if ((null != uList) && (uList.size() > 0)) { 
                        int i = 1;
                        for (User user : uList) {
                    %>
                    <li><a href="<%=basePath%>user?action=myblog&userId=<%=user.getId()%>" target="_blank"><%=i%>. <%=user.getUserName()%></a></li>
                    <%
                    	i++;
                        } 
                    } else {
                    %>
                    <li>暂无排名，抱歉......
                    </li>
                    <%
                    }
                    %>
                  </ul>
                </div>
              </div>
          </div><!-- /well -->
          
          <div class="well">
            <h4>博文TOP10</h4>
            <div class="row">
                <div class="">
                  <ul class="list-unstyled">
                    <%
                    if(tenList!=null){
                    	int i=1;
                    	for(Article art:tenList){
                    %>
                    <li><a href="<%=basePath %>comment.html?action=post&artId=<%=art.getId() %>&userId=<%=art.getUserId() %>" target="_blank"><%=i %>. <%=art.getTitle() %></a></li>
                    <% 		i++;
                    	} 
                    } else { 
                    %>
                    <li>暂无排名，抱歉......
                    </li>
                    <% 
                    } 
                    %>
                  </ul>
                </div>
              </div>
          </div><!-- /well -->
        </div>
      </div>
    </div><!-- /.container -->
    
<jsp:include page="frame/Footer.jsp"></jsp:include>
