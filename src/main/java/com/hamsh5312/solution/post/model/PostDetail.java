package com.hamsh5312.solution.post.model;

import java.util.List;

import com.hamsh5312.solution.post.comment.model.CommentDetail;

public class PostDetail {

	private Post post;
	private boolean isLike;
	private List<CommentDetail> commentDetailList;
	
	public Post getPost() {
		return post;
	}
	public boolean isLike() {
		return isLike;
	}
	public void setLike(boolean isLike) {
		this.isLike = isLike;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public List<CommentDetail> getCommentDetailList() {
		return commentDetailList;
	}
	public void setCommentDetailList(List<CommentDetail> commentDetailList) {
		this.commentDetailList = commentDetailList;
	}
	
	
}
