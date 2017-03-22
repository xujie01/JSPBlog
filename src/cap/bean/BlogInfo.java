package cap.bean;

public class BlogInfo {
	private int id;
	private int userId;
	private String blogName;
	private String description;
	private String propagate;
	public int getId() {
		return id;
	}
	public String getPropagate() {
		return propagate;
	}
	public void setPropagate(String propagate) {
		this.propagate = propagate;
	}
	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getBlogName() {
		return blogName;
	}
	public void setBlogName(String blogName) {
		this.blogName = blogName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
}
