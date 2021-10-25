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
	
	public int deleteRecommendByPostId(@Param("postId") int postId);
	
	public List<Recommend> selectRecommendRankingList();
	
	public List<Integer> selectRecommendCount();
	
	
}
