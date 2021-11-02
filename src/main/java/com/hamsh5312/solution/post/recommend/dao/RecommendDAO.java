package com.hamsh5312.solution.post.recommend.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hamsh5312.solution.post.recommend.model.Recommend;

@Repository
public interface RecommendDAO {

	public int insertRecommend(
			@Param("userId") int userId
			, @Param("commentId") int commentId
			, @Param("commentCreateUserName") String commentCreateUserName);
	
	public int deleteRecommend(
			@Param("userId") int userId
			, @Param("commentId") int commentId
			, @Param("commentCreateUserName") String commentCreateUserName);
	
	public int selectCountRecommendByCommentIdUserId(
			@Param("commentId") int commentId
			, @Param("userId") int userId);
	
	public int selectCountRecommendByCommentId(@Param("commentId") int commentId);
	
	// 4등 보너스게임으로 인한 정보넣기
	public int insertFourthPeopleInfo(
			@Param("product") String product
			, @Param("fourthUserName") String fourthUserName);
	
	// 날짜 정보 가져오기
	public String selectBonusPeople(
			@Param("startDate") String startDate
			, @Param("endDate") String endDate);
	
	public int deleteRecommendByPostId(@Param("postId") int postId);
	
	public List<Recommend> selectRecommendRankingList();
	
	public List<String> selectTop3People();
	
	public List<Integer> selectRecommendCount();
	
	
}
