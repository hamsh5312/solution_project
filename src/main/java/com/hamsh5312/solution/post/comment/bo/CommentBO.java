package com.hamsh5312.solution.post.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hamsh5312.solution.post.comment.dao.CommentDAO;
import com.hamsh5312.solution.post.comment.model.Comment;

@Service
public class CommentBO {

	@Autowired
	private CommentDAO commentDAO;
	
	public int inputComment(int postId, int userId, String userName, String content) {
		return commentDAO.insertComment(postId, userId, userName, content);
	}
	
	// postId 에 해당하는 댓글 리스트 가져오기
	public List<Comment> getCommentListByPostId(int postId){
		return commentDAO.selectCommentListByPostId(postId);
	}
	
	// postId 를 대상으로 삭제
	public int deleteCommentByPostId(int postId) {
		return commentDAO.deleteCommentByPostId(postId);
	}	
	
	// 모든 댓글리스트
	public List<Comment> getCommentList(){
		return commentDAO.selectCommentList();
	}
	
	// commentId 에 의한 comment 샐랙트!
	public Comment getComment(int id) {
		return commentDAO.selectComment(id);
	}
	
	
}
