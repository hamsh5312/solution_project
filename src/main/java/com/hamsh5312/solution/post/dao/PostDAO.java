package com.hamsh5312.solution.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hamsh5312.solution.post.model.Post;

@Repository
public interface PostDAO {

	public int insertPost(
			@Param("userId") int userId
			, @Param("userName") String userName
			, @Param("subject") String subject
			, @Param("content") String content
			, @Param("imagePath") String imagePath
			, @Param("sBox") String sBox);
	
	
	public List<Post> selectWorryList(
			@Param("pageStart") int pageStart
			, @Param("perPageNum") int perPageNum
			, @Param("sBox") String sBox);
	
	public List<Post> selectSearchWorryList(
			@Param("pageStart") int pageStart
			, @Param("perPageNum") int perPageNum
			, @Param("searchInput") String searchInput);	
	
	public List<Post> selectMyWorryList(
			@Param("pageStart") int pageStart
			, @Param("perPageNum") int perPageNum
			, @Param("userId") int userId);
	
	// 조회수
	public void increasePostHit(@Param("id") int id);
	
	// 찜 관련 
	
	public List<Post> selectLikeWorryList(
			@Param("pageStart") int pageStart
			, @Param("perPageNum") int perPageNum
			, @Param("likePostIdList") List<Integer> likePostIdList);
	
	
	public int selectCountLikeByUserIdPostId(
			@Param("postId") int postId
			, @Param("userId") int userId);
	
	public int insertLike(
			@Param("userId") int userId
			, @Param("postId") int postId);
	
	public int deleteLike(
			@Param("userId") int userId
			, @Param("postId") int postId);
	
	public List<Post> selectPostList();
	
	public List<Integer> selectLikePostIdByUserId(@Param("userId") int userId);
	
	public int selectNumber(@Param("category") String category);
	
	public int selectSearchInput(@Param("searchInput") String searchInput);
	
	public int selectMyNumber(@Param("userId") int userId);
	
	public Post selectWorry(@Param("id") int id);
	
	public Post selectPost(@Param("id") int id);
	
	// 포스트 삭제하기전에 해당 아이디가 삭제하도록
	public Post selectDeletePost(
			@Param("id") int id
			, @Param("userId") int userId);
	
	public int deletePost(
			@Param("id") int id
			, @Param("userId") int userId
			);
	
	public int selectLikePost(@Param("userId") int userId);
	
	public int updatePost(
			@Param("id") int id
			, @Param("userId") int userId
			, @Param("subject") String subject
			, @Param("content") String content);
	
	// 찜삭제
	public int deleteLikeByPostId(@Param("postId") int postId);
	
	
}
