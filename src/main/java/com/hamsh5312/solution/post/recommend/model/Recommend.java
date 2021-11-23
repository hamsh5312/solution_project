package com.hamsh5312.solution.post.recommend.model;

import java.util.Date;


public class Recommend {
	
	private int id;
	private String commentCreateUserName;
	private int commentId;
	
	// 아래 userId 는 추천을 누른 사람들의 userId
	private int userId;
	private Date createdAt;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCommentCreateUserName() {
		return commentCreateUserName;
	}
	public void setCommentCreateUserName(String commentCreateUserName) {
		this.commentCreateUserName = commentCreateUserName;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	
	
	
	
}
