# JSPBlog
基于Bootstrap、JSP和Servelet的博客系统
项目介绍
基于Bootstrap + JSP + Servelet 技术开发的入门级博客系统：业务逻辑采用JSP、Servelet、JavaBean的MVC模式。表示层主要完成数据的显示、接收用户的输入等功能，使用JSP实现；HTML用于数据的显示样式，JavaScript负责用户客户端的数据验证；JavaBean负责执行业务逻辑，封装对数据库表的操作，完成业务处理逻辑；Servelet则作为逻辑控制器，接收JSP传递的用户请求，根据情况将信息转发给JavaBean处理，JavaBean将处理结果返回给Servelet，最后返回结果给客户端。
系统功能：
	系统设置模块
在处理业务或系统运行之前一般都需要设置一些基础数据，本系统主要是管理员信息。该信息由系统管理员进行设置，具体管理操作主要包括增、删、改、查、统计、分类等。
	删除评论
管理员及普通用户可以对博客进行删除。
	删除博客
管理员及普通用户可以对博客进行删除。
	查看博客
管理员，普通用户及匿名用户可以对博客的内容、评论、浏览次数及发布日期进行查看。
	修改密码
系统管理员可以重置用户的密码，普通用户能修改自己的密码。
	博客信息管理
普通用户可以增加、修改博客及增加、回复评论。
组织结构
  
技术选型
后端技术:
	Servelet
	JavaBean
前端技术:
	jQuery
	Bootstrap
模块介绍
	公共类设计
设置数据源：将Oracle数据库的驱动程序复制到WEB-INF/lib目录，然后在META-INF目录下创建context.xml，并在web.xml中配置resource-ref。
公共类：cap.db包中DBPool.java数据库连接池的使用，实现增删改查。
	JSP模块
Index.jsp：网站首页。
Login.jsp：登陆页面。
Register.jsp：注册页面。
Profile.jsp：个人信息修改页面。
BlogInfo.jsp：个人博客信息修改页面。
Post.jsp：博文详情页面。
MyBlogIndex.jsp：获取作者当前页码博文。
ArcticleManager.jsp：博文管理页面。
AddArcticle.jsp：新建文章页面。
UpdateArtical.jsp：更新文章页面。
CategoryManager.jsp：个人文章分类管理页面。
AddCategory.jsp：新建个人文章分类页面。
EditCategory.jsp：编辑个人文章分类页面。
CommentManager.jsp：评论管理页面。
ApplyBlog.jsp：申请个人博客。
SearchResult.jsp：搜索文章结果页面。
AdminLogin.jsp：管理员登陆页面。
frame：Footer.jsp、Header.jsp页眉页脚引入Bootstrap及jQuery, 404.jsp错误网页。
Admin管理员相关页面： 
Index.jsp：控制面板。
UserAdmin.jsp：管理员用户管理界面。
UserProfile.jsp：用户详细信息。
SysArticleAdmin.jsp：文章管理页面。
SysCategoryAdmin.jsp：分类管理页面。
AddSysCategory.jsp：新建分类页面。
EditSysCategory.jsp：编辑系统分类页面。
	cap.bean(实体类)
Admin.java、Article.java、BlogInfo.java、Category.java、Comment.java、Counter.java、Profile.java、SysCategory.java、Ucomment.java、User.java。
	cap.action(Servelet)
IndexServlet.java：响应网站首页的Servelet，获取数据后至index.jsp。
UserServlet.java：用户相关操作的Servelet。
CommentServlet.java：博文详情及评论。
CategoryServlet.java：个人文章分类管理。
ArticleServlet.java：博文管理相关操作。
AdminServlet.java：管理员相关操作。
数据模型
 
环境搭建
开发工具:
	Oracle: 数据库
	Tomcat: 应用服务器
	SVN: 版本管理
	MyEclipse: 开发IDE
	PowerDesigner: 建模工具
开发环境：
	Jdk8
	Oracle11g
演示地址
演示地址： http://47.92.7.213:8080/blog/index.html
预览图

