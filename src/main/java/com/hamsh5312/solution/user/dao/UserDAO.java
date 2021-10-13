package com.hamsh5312.solution.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hamsh5312.solution.user.model.User;

@Repository
public interface UserDAO {
	
	
	public int insertUser(
			@Param("loginId") String loginId
			, @Param("password") String password
			, @Param("name") String name
			, @Param("email") String email
			, @Param("introduce") String introduce);
	
	
	public int selectCountById(@Param("loginId") String loginId);
	
	public User selectUserByLoginIdPassword(
			@Param("loginId") String loginId
			, @Param("password") String password);
	
	
	
}
