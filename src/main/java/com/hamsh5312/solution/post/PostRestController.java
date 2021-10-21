package com.hamsh5312.solution.post;

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
import org.springframework.web.multipart.MultipartFile;

import com.hamsh5312.solution.post.bo.PostBO;
import com.hamsh5312.solution.post.model.Post;

@RestController
@RequestMapping("/post")
public class PostRestController {

	
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/worry_create")
	public Map<String ,String> create(
			@RequestParam("subject") String subject
			, @RequestParam("content") String content
			, @RequestParam(value = "file") MultipartFile file
			, @RequestParam("sBox") String sBox
			, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		// getAttribute의 리턴형이 Object 형이라서  형변환이 필요
		Integer userId = (Integer)session.getAttribute("userId");
		String userName = (String)session.getAttribute("userName");
		
		Map<String, String> result = new HashMap<>();
		
		if(userId != null) {
			int count = postBO.addPost(userId, userName, subject, content, file, sBox);
			 
			if(count == 1) {
				result.put("result", "success");
			}else {
				result.put("result", "fail");
			}	
			
			return result; 
		}else {
			result.put("result", "noUserId");
			return result;
		}
		
		
	}
	
	
	@GetMapping("/delete")
	public Map<String ,String> delete(@RequestParam("postId") int postId
			, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		
		Map<String ,String> result = new HashMap<>();
		
		Post deleteCheck = postBO.postDeleteCheck(postId, userId);
		
		if(deleteCheck != null) {
			int count = postBO.deletePost(postId, userId);
			if(count == 0) {
				result.put("result", "fail");
			}else {
				result.put("result", "success");
			}
			return result;
		}else {
			result.put("result", "noMatch");
			return result;
		}
		
		
	}
	
	
	@PostMapping("/update")
	public Map<String, String> update(
			@RequestParam("postId") int postId
			, @RequestParam("subject") String subject
			, @RequestParam("content") String content
			, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		int userId = (Integer)session.getAttribute("userId");
		
		Map<String ,String> result = new HashMap<>();
		
		int count = postBO.updatePost(postId, userId, subject, content);
		if(count == 0) {
			result.put("result", "fail");
		}else {
			result.put("result", "success");
		}
		
		return result;
		
	}
	
	
	
}
