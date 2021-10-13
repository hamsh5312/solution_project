package com.hamsh5312.solution.Wpost.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface W_PostDAO {

	public int insertWPost(
			@Param("userId") int userId
			, @Param("userName") String userName
			, @Param("subject") String subject
			, @Param("content") String content
			, @Param("imagePath") String imagePath
			, @Param("sBox") String sBox);
	
	
}
