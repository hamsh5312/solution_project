package com.hamsh5312.solution.post.recommend;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hamsh5312.solution.post.recommend.bo.RecommendBO;

@RestController
@RequestMapping("/post")
public class RecommendRestController {
	
	
	@Autowired
	private RecommendBO recommendBO;
	
	@GetMapping("/recommend")
	public Map<String, String> like(
			@RequestParam("commentId") int commentId
			, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		
		
		Map<String, String> result = new HashMap<>();
		
		if(userId != null) {
			boolean recommend = recommendBO.recommend(userId, commentId);
			if(recommend) {
				result.put("result","success");			
			}else {
				result.put("result", "fail");
			}	
		}else { 
			result.put("result","noLogin");
		}
		
		return result;
	}
	
	
	
}
