package com.hamsh5312.solution.Wpost;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hamsh5312.solution.Wpost.bo.W_PostBO;
import com.hamsh5312.solution.Wpost.model.W_Post;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	private W_PostBO w_postBO;
	
	@GetMapping("/create_worry_view")
	public String createWorryView() {
		return "post/worryCreateView";
	}
	
	@GetMapping("/worry_list_view")
	public String worryListView(
			Model model
			, HttpServletRequest request) {
		
//		HttpSession session = request.getSession();
//		int userId = (Integer)session.getAttribute("userId");
		
		List<W_Post> postList = w_postBO.getPostList();
		model.addAttribute("postList", postList);
		
		
		return "post/worryListView";
	}
	
	
	@GetMapping("/worry_detail_view")
	public String worryDetail(
			@RequestParam("id") int id
			, Model model
			, HttpServletRequest request) {
		
//		HttpSession session = request.getSession();
//		int userId = (Integer)session.getAttribute("userId");
		
		W_Post w_post = w_postBO.getWorryPost(id);
		model.addAttribute("w_post", w_post);
		return "post/worryDetailView";
	}
	
}
