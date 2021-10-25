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
	
	public int selectNumber(@Param("category") String category);
	
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
	
	public int updatePost(
			@Param("id") int id
			, @Param("userId") int userId
			, @Param("subject") String subject
			, @Param("content") String content);
	
	
	
}
