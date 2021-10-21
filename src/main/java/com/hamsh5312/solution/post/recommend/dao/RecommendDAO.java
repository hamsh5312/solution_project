package com.hamsh5312.solution.post.recommend.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RecommendDAO {

	public int insertRecommend(
			@Param("userId") int userId
			, @Param("commentId") int commentId);
	
	public int deleteRecommend(
			@Param("userId") int userId
			, @Param("commentId") int commentId);
	
	public int selectCountRecommendByCommentIdUserId(
			@Param("commentId") int commentId
			, @Param("userId") int userId);
	
	public int selectCountRecommendByCommentId(@Param("commentId") int commentId);
	
	public int deleteRecommendByPostId(@Param("postId") int postId);
	
	
}
