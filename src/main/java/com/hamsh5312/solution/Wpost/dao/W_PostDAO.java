package com.hamsh5312.solution.Wpost.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hamsh5312.solution.Wpost.model.W_Post;

@Repository
public interface W_PostDAO {

	public int insertWPost(
			@Param("userId") int userId
			, @Param("userName") String userName
			, @Param("subject") String subject
			, @Param("content") String content
			, @Param("imagePath") String imagePath
			, @Param("sBox") String sBox);
	
	public List<W_Post> selectPostList();
	
	public W_Post selectWorryPost(
			@Param("id") int id
			);
	
	
}
