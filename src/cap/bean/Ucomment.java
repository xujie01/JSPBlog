package cap.bean;

import java.sql.Timestamp;
/**
 * 此实体类对应于ucomment视图，方便进行查询
 *
 */
public class Ucomment {
	private int aid;//文章主键
	private int cid;//评论主键
	private String ccontent;//评论内容
	private String username;//评论用户
	private String title;//评论的文章标题
	private Timestamp publish_time;//评论发布时间
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getCcontent() {
		return ccontent;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getPublish_time() {
		return publish_time;
	}
	public void setPublish_time(Timestamp publish_time) {
		this.publish_time = publish_time;
	}
	
	

}
