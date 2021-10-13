package com.hamsh5312.solution.Wpost;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hamsh5312.solution.Wpost.bo.W_PostBO;

@RestController
@RequestMapping("/post")
public class PostRestController {

	@Autowired
	private W_PostBO w_postBO;
	
	@PostMapping("/worry_create")
	public Map<String ,String> create(
			@RequestParam("subject") String subject
			, @RequestParam("content") String content
			, @RequestParam("file") MultipartFile file
			, @RequestParam("worrySelect") String worrySelect
			, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		// getAttribute의 리턴형이 Object 형이라서  형변환이 필요
		int userId = (Integer)session.getAttribute("userId");
		String userName = (String)session.getAttribute("userName");
		
		int count = w_postBO.addPost(userId, userName, subject, content, file, worrySelect);
		
		Map<String, String> result = new HashMap<>();
		
		if(count == 1) {
			result.put("result", "success");
		}else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	
}
