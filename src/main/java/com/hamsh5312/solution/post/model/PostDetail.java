package com.hamsh5312.solution.post.model;

import java.util.List;

import com.hamsh5312.solution.post.comment.model.CommentDetail;

public class PostDetail {

	private Post post;
	// 아래 이전 변수명 commentList 를 commentDetailList 로 변경함
	private List<CommentDetail> commentDetailList;
	
//	private boolean isRecommend;
//	private int recommendCount;
	
	public Post getPost() {
		return post;
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
