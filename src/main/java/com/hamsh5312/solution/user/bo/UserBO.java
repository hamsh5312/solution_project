package com.hamsh5312.solution.user.bo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hamsh5312.solution.common.EncryptUtils;
import com.hamsh5312.solution.user.dao.UserDAO;
import com.hamsh5312.solution.user.model.User;

@Service
public class UserBO {
	
	@Autowired
	private UserDAO userDAO;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public int signUp(String loginId, String password, String name, String email, String introduce) {
		
		// password 암호화
		String encryptPassword = EncryptUtils.md5(password);
		
		if(encryptPassword.equals("")) {
			logger.error("[UserBO signUP] 암호화 실패!!!!!!!!!!!!!!");
			return 0;
		}
		
		
		return userDAO.insertUser(loginId, encryptPassword, name, email, introduce);
	}
	
	// 아이디 중복확인
	public boolean isDuplicateId(String loginId) {
		
		if(userDAO.selectCountById(loginId) == 0) {
			return false;
		} else {
			return true;
		}
		
//		위의 if ~ else 문을 아래와 같이 한문장으로 표현 가능 	
		// return (userDAO.selectCountById(loginId) != 0);
		
	}
	
	// 닉네임 중복확인
	public boolean isDuplicateName(String name) {
		if(userDAO.selectCountByName(name) == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	
	public User signIn(String loginId, String password) {
		// 비밀번호를 암호화 하고 DAO 로 전달한다.
		String encryptPassword = EncryptUtils.md5(password);
		
		return userDAO.selectUserByLoginIdPassword(loginId, encryptPassword); 
	}
	
	
}
