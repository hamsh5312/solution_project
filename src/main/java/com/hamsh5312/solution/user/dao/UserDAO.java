package com.hamsh5312.solution.user.dao;

import java.util.List;

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
	
	// 아이디 중복확인
	public int selectCountById(@Param("loginId") String loginId);
	// 닉네임 중복확인
	public int selectCountByName(@Param("name") String name);
	
	public User selectUserByLoginIdPassword(
			@Param("loginId") String loginId
			, @Param("password") String password);
	
	
	public List<User> selectUser();
	
	
}
