-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
create table admin--管理员表
(
  id       NUMBER not null,--管理员编号（主键）
  username VARCHAR2(64) not null,--管理员昵称
  password VARCHAR2(64) not null,--管理员密码
  constraint PK_ADMIN primary key (ID)
);

-- ----------------------------
-- Records of admin
-- ----------------------------
insert into admin (id,username,password) values(1,'admin','admin');
commit;

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
create table muser--用户信息表
(
  ID         NUMBER not null,--用户编号（主键）
  USERNAME   VARCHAR2(32) default '0' not null,--用户名
  PASSWORD   VARCHAR2(64) default '0' not null,--用户密码
  EMAIL      VARCHAR2(32) default '0' not null,--邮箱
  IS_APPLIED NUMBER default 0 not null,--是否已激活
  IS_DELETE  NUMBER default 0 not null,--是否已删除
  IS_PROFILE NUMBER default 0 not null,--个人信息是否完善
  constraint PK_MUSER primary key (ID)
)

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO muser VALUES ('1', 'admin', 'admin', '1303996779@qq.com', 1, 0, 1);
INSERT INTO muser VALUES ('2', 'uname1', '123', 'admin@chinadota2.com', 1, 0, 1);
INSERT INTO muser VALUES ('3', 'huanchuanjian', '123', 'chuanjian.huan@wbkit.com', 1, 0, 1);
INSERT INTO muser VALUES ('4', 'huan', '123', 'xunhua.zhang@wbkit.com', 1, 0, 0);
INSERT INTO muser VALUES ('5', 'chuan', '123', 'chuan@chuan.com', 1, 0, 0);
INSERT INTO muser VALUES ('6', 'liulu', '123', 'liulu@qq.com', 0, 0, 0);
INSERT INTO muser VALUES ('7', 'hello', '123', 'hello@qq.com', 0, 0, 0);
INSERT INTO muser VALUES ('8', 'world', '123', 'world1@qq.com', 0, 0, 0);
INSERT INTO muser VALUES ('9', 'test', 'test', 'test@test.com', 1, 0, 1);
INSERT INTO muser VALUES ('10', 'starlee2008', 'starlee', 'starlee2008@163.com', 1, 0, 0);
INSERT INTO muser VALUES ('11', 'starlee1999', 'l12345678', 'starlee2008@126.com', 1, 1, 0);
INSERT INTO muser VALUES ('15', 'admin2008', '123456', 'starlee2008@yeah.com', 1, 0, 0);
INSERT INTO muser VALUES ('16', 'hellossssss', 'l12345678', 'world@qq.com', 0, 0, 0);
commit;

-- ----------------------------
-- Table structure for `profile`
-- ----------------------------
CREATE TABLE profile (--个人信息表
  id NUMBER NOT NULL,--个人编号（主键）
  user_id NUMBER DEFAULT 0 NOT NULL,--用户编号
  first_name VARCHAR2(64) DEFAULT '0' NOT NULL,--名
  last_name VARCHAR2(64) DEFAULT '0' NOT NULL,--姓
  gender NUMBER DEFAULT 0 NOT NULL,--性别
  telephone VARCHAR2(64) NOT NULL,--电话
  constraint PK_profile primary key (ID),
  constraint fk_profile_id foreign key (user_id) references muser(id)
);
ALTER TABLE profile DROP CONSTRAINT fk_profile_id;--删除外键约束

-- ----------------------------
-- Records of profile
-- ----------------------------
INSERT INTO profile VALUES (8, 1, '王', '123', 0, '18551702658');
INSERT INTO profile VALUES (9, 2, '吴', '成', 0, '12345678');
INSERT INTO profile VALUES (10, 3, '王', '成', 1, '12345678');
INSERT INTO profile VALUES (11, 9, 'test_name', 'test_last_name', 1, '12345');
commit;

-- ----------------------------
-- Table structure for `sys_category`
-- ----------------------------
CREATE TABLE sys_category (--系统分类信息表
  id NUMBER NOT NULL,--系统分类编号
  category_name VARCHAR2(64) DEFAULT '0' NOT NULL,--系统分类名
  articals NUMBER DEFAULT 0,--分类文章总数
  is_delete NUMBER DEFAULT 0 NOT NULL,--是否删除
  constraint PK_sys_category primary key (ID)
);

-- ----------------------------
-- Records of sys_category
-- ----------------------------
INSERT INTO sys_category VALUES (1, 'struts2', 120, 0);
INSERT INTO sys_category VALUES (2, 'Spring框架', 345, 0);
INSERT INTO sys_category VALUES (3, '无分类', 0, 0);
INSERT INTO sys_category VALUES (4, 'lua', 0, 0);
INSERT INTO sys_category VALUES (5, 'hibernate', 1, 0);
INSERT INTO sys_category VALUES (6, 'jquery', 1, 0);
commit;

-- ----------------------------
-- Table structure for category
-- ----------------------------
CREATE TABLE category (--个人分类信息表
  id NUMBER NOT NULL,--个人分类编号
  user_id NUMBER DEFAULT 0 NOT NULL,--用户编号
  category_name VARCHAR2(64) DEFAULT '0' NOT NULL,--个人分类名
  articals NUMBER DEFAULT 0 NOT NULL,--个人文章数量
  is_delete NUMBER DEFAULT 0 NOT NULL,--是否删除
  constraint PK_category primary key (ID),
  constraint fk_category_id foreign key (user_id) references muser(id)
);
ALTER TABLE category DROP CONSTRAINT fk_category_id;--删除外键约束

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO category VALUES (1, 1, '网络', 123, 1);
INSERT INTO category VALUES (2, 1, '嵌入式技术', 123, 1);
INSERT INTO category VALUES (3, 1, 'Nodejs', 213, 0);
INSERT INTO category VALUES (4, 2, '数据库原理', 213, 1);
INSERT INTO category VALUES (5, 2, '大数据', 213, 1);
INSERT INTO category VALUES (6, 2, '微内核', 213, 1);
INSERT INTO category VALUES (8, 1, '数据库技术', 0, 0);
INSERT INTO category VALUES (9, 2, '嵌入式', 0, 0);
INSERT INTO category VALUES (10, 1, 'web socket', 0, 1);
INSERT INTO category VALUES (11, 2, 'Nginx', 0, 0);
INSERT INTO category VALUES (12, 2, 'MySQL', 0, 0);
INSERT INTO category VALUES (13, 5, '无分类', 0, 0);
INSERT INTO category VALUES (14, 5, 'Nodejs', 0, 0);
INSERT INTO category VALUES (15, 5, '网络', 0, 0);
INSERT INTO category VALUES (16, 9, '无分类', 0, 0);
INSERT INTO category VALUES (17, 10, '无分类', 0, 0);
INSERT INTO category VALUES (18, 10, 'JSP博客', 0, 0);
INSERT INTO category VALUES (19, 1, 'JSPServlet技术+', 0, 0);
INSERT INTO category VALUES (20, 1, 'Springmvc技术', 0, 1);
INSERT INTO category VALUES (21, 1, 'nodejs技术', 0, 0);
INSERT INTO category VALUES (22, 1, 'test', 0, 1);
INSERT INTO category VALUES (23, 11, '无分类', 0, 0);
INSERT INTO category VALUES (24, 1, 'test', 0, 0);
INSERT INTO category VALUES (26, 1, '网络技术2', 0, 0);
INSERT INTO category VALUES (27, 15, '无分类', 1, 0);
commit;

-- ----------------------------
-- Table structure for blog_info
-- ----------------------------
CREATE TABLE blog_info (--博客信息表
  id NUMBER NOT NULL,--博客编号
  user_id NUMBER DEFAULT 0 NOT NULL,--用户编号
  blog_name VARCHAR2(100) DEFAULT '0' NOT NULL,--博客名
  description VARCHAR2(1000),--描述
  propagate VARCHAR2(128),--宣传
  constraint PK_blog_info primary key (ID),
  constraint fk_blog_info_id foreign key (user_id) references muser(id)
);
ALTER TABLE blog_info DROP CONSTRAINT fk_blog_info_id;--删除外键约束

-- ----------------------------
-- Records of blog_info
-- ----------------------------
INSERT INTO blog_info VALUES (7, 1, '博客名称', '博客描述', '这是我的个人技术博客。欢迎光临！xxx');
INSERT INTO blog_info VALUES (8, 2, '宦传建', '这是我的个人技术博客', '这是我的个人技术博客');
INSERT INTO blog_info VALUES (9, 3, '云风的Blog', '—— 思绪来的快，走的也快。偶尔在这里停留', '近期由于事务繁忙，博客不能及时更新。希望各位读者不要见谅哈');
INSERT INTO blog_info VALUES (12, 4, '专注于Linux x86_64平台的高性能web服务器', '—— 思绪来的快，走的也快。偶尔在这里停留', '专注于Linux x86_64平台的高性能web服务器');
INSERT INTO blog_info VALUES (13, 5, 'chuan的个人博客', '这是我的技术博客', '最近要休假了');
INSERT INTO blog_info VALUES (14, 9, 'test的博客', 'test的博客描述', 'test今天注册了该博客');
INSERT INTO blog_info VALUES (15, 10, 'starlee2008', 'Servlet技术博客', '欢迎来到我的博客，请多多捧场');
INSERT INTO blog_info VALUES (16, 11, 'starlee2008', 'JSP技术博客', '欢迎大家光临');
INSERT INTO blog_info VALUES (17, 15, '博客名称', '博客描述', '这是我的个人技术博客。欢迎光临！xxx');
INSERT INTO blog_info VALUES (18, 15, '博客名称', '博客描述', '这是我的个人技术博客。欢迎光临！xxx');
commit;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
CREATE TABLE article (--文章信息表
  id NUMBER NOT NULL,--文章编号
  user_id NUMBER DEFAULT 0 NOT NULL,--用户编号
  sys_category_id NUMBER DEFAULT 0 NOT NULL,--系统分类编号
  category_id NUMBER DEFAULT 0 NOT NULL,--个人分类编号
  title VARCHAR2(60) DEFAULT '0' NOT NULL,--标题
  content CLOB NOT NULL,--内容
  summary CLOB NOT NULL,--文章摘要
  publish_time DATE DEFAULT sysdate NOT NULL,--发表时间
  is_top NUMBER DEFAULT 0 NOT NULL,--是否置顶
  is_delete NUMBER DEFAULT 0 NOT NULL,--是否删除
  count NUMBER DEFAULT 0 NOT NULL,--文章点击数
  constraint PK_article primary key (ID),
  constraint fk_article_id foreign key (user_id) references muser(id),
  constraint fk_scategory foreign key (sys_category_id) references sys_category(id),
  constraint fc_category foreign key (category_id) references category(id)
);
ALTER TABLE article DROP CONSTRAINT fk_article_id;--删除外键约束
ALTER TABLE article DROP CONSTRAINT fk_scategory;--删除外键约束
ALTER TABLE article DROP CONSTRAINT fc_category;--删除外键约束


-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO article VALUES (1, 1, 1, 1,'第一篇文章', '这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用', '这是第一篇文章。。。XXX', to_date('2013-10-23 15:57:07','YYYY-MM-DD HH24:MI:SS'), 0, 0, 24);
INSERT INTO article VALUES (2, 2, 1, 1,'第一篇文章',  '这是第一篇文章的内容，测试使用', '这是第1篇文章。。。这是第1篇文章。。。这是第1篇文章。。。这是第1篇文章。。。这是第1篇文章。。。这是第1篇文章。。。这是第1篇文章。。。这是第1篇文章。。。这是第1篇文章。。。', to_date('2013-10-23 15:57:34','YYYY-MM-DD HH24:MI:SS'), 0, 0, 6);
INSERT INTO article VALUES (3, 2, 1, 1, '第一篇文章', '这是第一篇文章的内容，测试使用', '这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。这是第2篇文章。。。', to_date('2013-10-23 15:57:47','YYYY-MM-DD HH24:MI:SS'), 0, 0, 3);
INSERT INTO article VALUES (4, 2, 1, 1, '第一篇文章', '这是第一篇文章的内容，测试使用', '这是第3篇文章。。。', to_date('2013-10-23 15:57:48','YYYY-MM-DD HH24:MI:SS'), 0, 0, 1);
INSERT INTO article VALUES (5,  2, 1, 1,'第一篇文章', '这是第一篇文章的内容，测试使用', '这是第4篇文章。。。', to_date('2013-10-23 15:57:49','YYYY-MM-DD HH24:MI:SS'), 0, 0, 4);
INSERT INTO article VALUES (6, 2, 1, 1, '第一篇文章', '这是第一篇文章的内容，测试使用', '这是第5篇文章。。。', to_date('2013-10-23 15:57:50','YYYY-MM-DD HH24:MI:SS'), 0, 0, 2);
INSERT INTO article VALUES (7, 2, 1, 1, '第一篇文章', '这是第一篇文章的内容，测试使用', '这是第6篇文章。。。', to_date('2013-10-23 15:57:51','YYYY-MM-DD HH24:MI:SS'), 0, 0, 15);
INSERT INTO article VALUES (8, 2, 1, 1, '第一篇文章', '这是第一篇文章的内容，测试使用', '这是第7篇文章。。。', to_date('2013-10-23 15:57:52','YYYY-MM-DD HH24:MI:SS'), 0, 0, 57);
INSERT INTO article VALUES (9, 2, 2, 6,'2013年10月26日晚', '2013年10月26日晚', '2013年10月26日晚', to_date('2013-10-26 23:37:54','YYYY-MM-DD HH24:MI:SS'), 0, 0, 7);
INSERT INTO article VALUES (10, 2, 1, 12, '2013年10月27日早', '2013年10月27日早 - 继续写Jsp blog', '2013年10月27日早', to_date('2013-10-28 20:00:04','YYYY-MM-DD HH24:MI:SS'), 0, 1, 1);
INSERT INTO article VALUES (11, 2, 1, 5,  '2013年10月27日早 - 2','2013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 2', '2013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 22013年10月27日早 - 2', to_date('2013-10-27 12:45:41','YYYY-MM-DD HH24:MI:SS'), 0, 1, 24);
INSERT INTO article VALUES (12, 1, 1, 2, '2013年10月27日早 - 20', '2013年10月27日早 - 32013年10月27日早 - 32013年10月27日早 - 32013年10月27日早 - 32013年10月27日早 - 32013年10月27日早 - 32013年10月27日早 - 32013年10月27日早 - 3', '2013年10月27日早 - 32013年10月27日早 - 3', to_date('2013-10-28 15:21:19','YYYY-MM-DD HH24:MI:SS'), 0, 1, 28);
INSERT INTO article VALUES (13,2, 1, 4, 'ra叔',  'ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔', 'ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔ra叔', to_date('2013-10-28 09:28:37','YYYY-MM-DD HH24:MI:SS'), 0, 1, 4);
INSERT INTO article VALUES (14, 1, 1, 3,  '管理写的好烦','管理写的好烦管理写的好烦', '管理写的好烦管理写的好烦', to_date('2013-10-28 16:03:17','YYYY-MM-DD HH24:MI:SS'), 0, 1, 9);
INSERT INTO article VALUES (15, 2, 2, 12, 23, '段落1\r\n段落2\r\n  段落3\r\n段落4', '123', to_date('2013-10-28 21:00:09','YYYY-MM-DD HH24:MI:SS'), 0, 1, 9);
INSERT INTO article VALUES (16, 2, 2, 12,  '博客做的差不多了，还有几个功能点需要实现','今天29号了，还有几天就走了。项目也快做好了，又要工作了。SB学校不解释，WC', '今天29号了，还有几天就走了。项目也快做好了，又要工作了。', to_date('2013-10-29 15:10:52','YYYY-MM-DD HH24:MI:SS'), 0, 1, 5);
INSERT INTO article VALUES (17,  5, 2, 14,'这是chuan的文章', '这是chuan的文章的摘要内容', '这是chuan的文章的摘要', to_date('2013-10-30 12:20:16','YYYY-MM-DD HH24:MI:SS'), 0, 1, 1);
INSERT INTO article VALUES (18,  1, 1, 8,'嵌入式实时OS','实时线程操作系统内部采用面向对象的方式设计，内建内核对象管理系统，能够访问/管理所有内核对象。内核对象包含了内核中绝大部分设施，而这些内核对象可 以是静态分配的静态对象，也可以是从系统内存堆中分配的动态对象。通过内核对象系统，RT-Thread可以做到不依赖于具体的内存分配方式，伸缩性得到 极大的加强。', '实时线程操作系统内部采用面向对象的方式设计，内建内核对象管理系统，能够访问/管理所有内核对象。内核对象包含了内核中绝大部分设施，而这些内核对象可 以是静态分配的静态对象，也可以是从系统内存堆中分配的动态对象。', to_date('2013-11-02 14:57:35','YYYY-MM-DD HH24:MI:SS'), 0, 0, 3);
INSERT INTO article VALUES (19, 9, 4, 16, 'Openresty', '昨天学习了Yichun Zhang的Openresty，很nice的华人工程师。很优秀的开源项目\r\nOpenresty is a fast web server', '昨天学习了Yichun Zhang的Openresty，很nice的华人工程师。很优秀的开源项目', to_date('2013-11-06 14:53:59','YYYY-MM-DD HH24:MI:SS'), 0, 0, 2);
INSERT INTO article VALUES (20,  1, 2, 8, 'Spring第一讲','测试Spring技术', '测试Spring技术', to_date('2014-05-17 15:21:05','YYYY-MM-DD HH24:MI:SS'), 0, 1, 8);
INSERT INTO article VALUES (21, 1, 4, 10, 'Spring第2讲', '测试第二讲', '测试第二讲', to_date('2014-05-17 15:21:39','YYYY-MM-DD HH24:MI:SS'), 0, 0, 7);
INSERT INTO article VALUES (22, 1, 4, 10, 'Spring第2讲','测试第二讲,再次测试', '测试第二讲', to_date('2014-05-17 15:28:39','YYYY-MM-DD HH24:MI:SS'), 0, 1, 6);
INSERT INTO article VALUES (23, 1, 1, 3, '第一篇文章', '这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用，++++', '这是第一篇文章。。。', to_date('2014-05-18 21:38:05','YYYY-MM-DD HH24:MI:SS'), 0, 1, 5);
INSERT INTO article VALUES (24,  1, 1, 3,'第一篇文章', '这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用这是第一篇文章的内容，测试使用，nonoo', '这是第一篇文章。。。', to_date('2014-05-20 14:55:59','YYYY-MM-DD HH24:MI:SS'), 0, 0, 4);
INSERT INTO article VALUES (25,  1, 4, 21,'Spring第3讲', '是否是舒服舒服是否是发输电佛挡杀佛随碟附送的发生的发三点', '今天测试一下如何', to_date('2014-09-15 22:23:42','YYYY-MM-DD HH24:MI:SS'), 0, 0, 16);
INSERT INTO article VALUES (26,  1, 4, 21,'是否是 ', '随碟附送', '豕分蛇断发', to_date('2014-05-21 19:55:04','YYYY-MM-DD HH24:MI:SS'), 0, 0, 8);
INSERT INTO article VALUES (27, 1, 1, 2, 'ssh2测试', '123456', '测试', to_date('2014-09-20 22:00:50','YYYY-MM-DD HH24:MI:SS'), 0, 0, 0);
INSERT INTO article VALUES (28,  1, 2, 3,'xxxx1', 'xxx1', 'xxx1', to_date('2014-09-20 22:06:29','YYYY-MM-DD HH24:MI:SS'), 0, 0, 1);
INSERT INTO article VALUES (29, 1, 6, 26, 'xxxx', 'xxxxxxxxxxxxxxxxxxxxxxxx', 'xxxx', to_date('2015-11-16 11:26:32','YYYY-MM-DD HH24:MI:SS'), 0, 0, 7);
commit;

-- ----------------------------
-- Table structure for `counter`
-- ----------------------------
CREATE TABLE counter (--统计信息表
  id NUMBER NOT NULL,--统计编号
  num NUMBER DEFAULT 0 NOT NULL,--统计网站浏览次数
  constraint PK_counter primary key (ID)
);

-- ----------------------------
-- Records of counter
-- ----------------------------
INSERT INTO counter VALUES (1, 111);
commit;

-- ----------------------------
-- Table structure for mcomment
-- ----------------------------
CREATE TABLE mcomment (--评论信息表
  id NUMBER NOT NULL,--评论编号
  user_id NUMBER DEFAULT 0 NOT NULL,--用户编号
  artical_id NUMBER DEFAULT 0 NOT NULL,--文章编号
  content VARCHAR2(1000) DEFAULT '0' NOT NULL,--评论内容
  time DATE DEFAULT sysdate NOT NULL,--评论时间
  is_delete NUMBER DEFAULT 0 NOT NULL,--是否删除
  constraint PK_comment primary key (ID),
  constraint fk_comment1 foreign key (user_id) references muser(id),
  constraint fk_comment2 foreign key (artical_id) references article(id)
);
ALTER TABLE mcomment DROP CONSTRAINT fk_comment1;--删除外键约束
ALTER TABLE mcomment DROP CONSTRAINT fk_comment2;--删除外键约束

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO mcomment VALUES (1, 2, 2, '自己评论自己',  to_date('2013-10-25 16:19:51','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (2, 2, 3, '我又自己评论自己', to_date('2013-10-25 16:25:22','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (3, 1, 1, '我是谁', to_date('2013-10-25 16:27:44','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (4, 1, 1, '再评论一次', to_date('2013-10-25 16:28:34','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (5, 1, 1, '评论来了，test', to_date('2013-10-25 21:36:32','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (6, 1, 1, '继续评论之', to_date('2013-10-25 21:44:26','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (7, 1, 1, '继续评论之', to_date('2013-10-25 21:44:30','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (8, 2, 4, 'comment test', to_date('2013-10-25 21:50:27','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (9, 2, 6, 'comment test', to_date('2013-10-25 21:51:41','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (10, 2, 6, 'hello world', to_date('2013-10-25 21:51:59','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (11, 1, 7, '这是huanzh的评论', to_date('2013-10-25 22:49:08','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (12, 2, 1, '我和青哥打LOL', to_date('2013-10-26 15:58:16','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (13, 2, 6, '西至西', to_date('2013-10-26 16:46:19','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (14, 2, 11, '评论一发', to_date('2013-10-27 11:05:45','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (15, 2, 10, '10月28日评论', to_date('2013-10-28 09:30:14','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (16, 1, 12, '歪子来了', to_date('2013-10-28 15:21:04','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (17, 2, 10, 'comment  test',to_date( '2013-10-28 19:45:19','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (18, 1, 10, '评论一发', to_date('2013-10-28 20:46:47','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (19, 1, 14, 'etst', to_date('2013-10-29 19:24:29','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (20, 5, 17, '司副队长', to_date('2013-10-30 12:25:13','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (21, 1, 8, '测试一下',to_date( '2014-05-14 21:51:53','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (22, 1, 8, '再次测试', to_date('2014-05-14 21:52:05','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (23, 1, 18, '测试一下', to_date('2014-05-15 11:52:15','YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO mcomment VALUES (24, 1, 9, '评论测试', to_date('2014-05-15 19:32:19','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (25, 1, 19, '测试一下', to_date('2014-05-18 21:28:22','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (26, 1, 18, '测试', to_date('2014-05-21 19:50:55','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (27, 1, 26, '测试', to_date('2014-05-21 20:14:25','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (28, 1, 25, '测试', to_date('2014-09-16 00:24:00','YYYY-MM-DD HH24:MI:SS'), 0);
INSERT INTO mcomment VALUES (29, 1, 29, 'xxxhhhh', to_date('2015-11-17 09:57:25','YYYY-MM-DD HH24:MI:SS'), 0);
commit;

-- ----------------------------
-- View structure for `ucomment`
-- ----------------------------
CREATE VIEW ucomment AS select c.id AS cid,c.user_id AS cuid,c.artical_id AS artical_id,c.content AS ccontent,c.time AS ctime,c.is_delete AS cdelete,u.id AS uuid,u.username AS username,u.password AS password,u.email AS email,u.is_applied AS is_applied,u.is_delete AS udelete,u.is_profile AS is_profile,a.id AS aid,a.title AS title,a.user_id AS user_id,a.sys_category_id AS sys_category_id,a.category_id AS category_id,a.content AS acontent,a.summary AS summary,a.publish_time AS atime,a.is_top AS is_top,a.is_delete AS is_delete from (mcomment c join muser u on (c.is_delete = 0) and (u.id = c.user_id) join article a on (a.id = c.artical_id)) ;

-- ----------------------------
-- 使用序列和触发器创建自增ID
-- ----------------------------
CREATE SEQUENCE test_sequence2  
    increment by 1    -- 每次递增1  
    start with 30       -- 从1开始  
    nomaxvalue      -- 没有最大值  
    minvalue 1       -- 最小值=1  
    NOCYCLE;      -- 不循环
	
CREATE OR REPLACE TRIGGER BeforeadminInsert  
    BEFORE INSERT ON admin  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;
	
CREATE OR REPLACE TRIGGER BeforearticleInsert  
    BEFORE INSERT ON article  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;
	
CREATE OR REPLACE TRIGGER Beforeblog_infoInsert  
    BEFORE INSERT ON blog_info  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;
	
CREATE OR REPLACE TRIGGER BeforecategoryInsert  
    BEFORE INSERT ON category  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;
	
CREATE OR REPLACE TRIGGER BeforemcommentInsert  
    BEFORE INSERT ON mcomment  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;
	
CREATE OR REPLACE TRIGGER BeforecounterInsert  
    BEFORE INSERT ON counter  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;
	
CREATE OR REPLACE TRIGGER BeforeprofileInsert  
    BEFORE INSERT ON profile  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;
	
CREATE OR REPLACE TRIGGER Beforeasys_categoryInsert  
    BEFORE INSERT ON sys_category  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;	
	
CREATE OR REPLACE TRIGGER BeforemuserInsert  
    BEFORE INSERT ON muser  
	FOR EACH ROW  
	BEGIN  
	SELECT test_sequence2.nextval INTO :new.id  FROM dual;  
	END;