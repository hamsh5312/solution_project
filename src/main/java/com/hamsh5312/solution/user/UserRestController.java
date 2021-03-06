package com.hamsh5312.solution.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hamsh5312.solution.user.bo.UserBO;
import com.hamsh5312.solution.user.model.User;

@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@PostMapping("/sign_up")
	public Map<String, String> signUpFunction(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, @RequestParam("name") String name
			, @RequestParam("email") String email
			, @RequestParam("introduce") String introduce){
		
		
		Map<String, String> result = new HashMap<>();
		int count = userBO.signUp(loginId, password, name, email, introduce);
		
		if(count == 1) {
			result.put("result", "success");
			
		}else {
			result.put("result", "fail");
		}
		return result;	
	}
	
	
	
	// 아이디 중복확인
	@GetMapping("/is_duplicate_id")
	public Map<String, Boolean> isDuplicateId(@RequestParam("loginId") String loginId){
			
		Map<String, Boolean> result = new HashMap<>();
		
		if(userBO.isDuplicateId(loginId)) {
			result.put("is_duplicate", true);
		}else {
			result.put("is_duplicate", false);
		}
		
// 		위의 if ~ else 문을 아래와 같이 한 문장으로 표현 가능 		
//		result.put("is_duplicate", userBO.isDuplicateId(loginId));
		
		return result;	
	}
	
	// 닉네임 중복확인
	@GetMapping("/is_duplicate_name")
	public Map<String, Boolean> isDuplicateName(@RequestParam("name") String name){
			
		Map<String, Boolean> result = new HashMap<>(); 	
		if(userBO.isDuplicateName(name)) {
			result.put("is_duplicate", true);
		}else {
			result.put("is_duplicate", false);
		}
		return result;	
	}
	
	
	@PostMapping("/sign_in")
	public Map<String, String> signInFunction(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, HttpServletRequest request){
		
		User user = userBO.signIn(loginId, password);
		Map<String, String> result = new HashMap<>();
		
		if(user != null) {			
			result.put("result", "success");
			
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
			
		}else {
			result.put("result", "fail");
		}		
		return result;	
		
	}
	
	
}
