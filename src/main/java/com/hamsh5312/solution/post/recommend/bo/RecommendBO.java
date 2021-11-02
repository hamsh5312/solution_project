package com.hamsh5312.solution.post.recommend.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hamsh5312.solution.post.comment.bo.CommentBO;
import com.hamsh5312.solution.post.comment.model.Comment;
import com.hamsh5312.solution.post.recommend.dao.RecommendDAO;
import com.hamsh5312.solution.post.recommend.model.Recommend;

@Service
public class RecommendBO {


	@Autowired
	private RecommendDAO recommendDAO;
	
	@Autowired
	private CommentBO commentBO;
	
	public boolean recommend(int userId, int commentId) {
		
		// 추천 상태면 추천 취소
		if(this.recommendByCommentIdUserId(commentId, userId)) {
			Comment comment = commentBO.getComment(commentId);
			int count = recommendDAO.deleteRecommend(userId, commentId, comment.getUserName());
			if(count == 0) {
				return false;
			}else {
				return true;
			}
		}else {  // 추천 취소 상태면 추천
			// commentId 에 의한 해당 comment 선택
			Comment comment = commentBO.getComment(commentId);
			// 해당  comment 에서 userName 을 뽑아서  recommend 테이블에 컬럼으로 넣기
			int count = recommendDAO.insertRecommend(userId, commentId, comment.getUserName());
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
	
	// 4등 보너스 게임으로 인한 정보 넣기
	public int putFourthPeopleInfo(String product, String fourthUserName) {
		return recommendDAO.insertFourthPeopleInfo(product, fourthUserName);
	}
	
	// 4등 보너스 게임 사람 선택하기
	public String chooseBonusPeople(String startDate, String endDate) {
		return recommendDAO.selectBonusPeople(startDate, endDate);
	}
	
	public int deleteRecommendByPostId(int postId) {
		return recommendDAO.deleteRecommendByPostId(postId);
	}
	
	//
	
	public List<Recommend> getRecommendRankingList(){
		return recommendDAO.selectRecommendRankingList();
	}
	
	public List<String> getTop3People(){
		return recommendDAO.selectTop3People();
	}
	
	public List<Integer> getRecommendTotalCount(){
		return recommendDAO.selectRecommendCount();
	}
	
}
