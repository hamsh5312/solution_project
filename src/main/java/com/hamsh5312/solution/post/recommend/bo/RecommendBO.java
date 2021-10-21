package com.hamsh5312.solution.post.recommend.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hamsh5312.solution.post.recommend.dao.RecommendDAO;

@Service
public class RecommendBO {


	@Autowired
	private RecommendDAO recommendDAO;
	
	public boolean recommend(int userId, int commentId) {
		
		// 추천 상태면 추천 취소
		if(this.recommendByCommentIdUserId(commentId, userId)) {
			int count = recommendDAO.deleteRecommend(userId, commentId);
			if(count == 0) {
				return false;
			}else {
				return true;
			}
		}else {  // 추천 취소 상태면 추천
			int count = recommendDAO.insertRecommend(userId, commentId);
			if(count == 1) {
				return true;
			}else {
				return false;
			}
		}
		
	}
	
	
	// commentId 와 userId로 추천 여부 확인
	public boolean recommendByCommentIdUserId(int commentId, int userId) {
		int count = recommendDAO.selectCountRecommendByCommentIdUserId(commentId, userId);
		
		if(count == 0) {
			return false;
		}else {
			return true;
		}	
	}
	
	// commentId 로 생성된 추천 개수
	public int recommendCount(int commentId) {
		return recommendDAO.selectCountRecommendByCommentId(commentId);
	}
	
	
	public int deleteRecommendByPostId(int postId) {
		return recommendDAO.deleteRecommendByPostId(postId);
	}
	
		
	
}
