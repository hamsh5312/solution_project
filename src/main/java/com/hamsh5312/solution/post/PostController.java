package com.hamsh5312.solution.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hamsh5312.solution.common.Criteria;
import com.hamsh5312.solution.common.PageMaker;
import com.hamsh5312.solution.post.bo.PostBO;
import com.hamsh5312.solution.post.model.Post;
import com.hamsh5312.solution.post.model.PostDetail;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostBO postBO;
	
	@GetMapping("/create_view")
	public String create() {
		return "post/createView";
	}
	
	@GetMapping("/list_view")
	public String listView(Model model) {
		// 파라미터 추가해서 옵션을위한.. 공부인지 음악인지  필수가 아닌거를 설정
		
		PageMaker pageMaker = new PageMaker();
		Criteria cri = new Criteria();
		
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(100);
		List<Post> worryList = postBO.getWorryList();
		model.addAttribute("worryList", worryList);
		
		
		
		return "post/listView";
	}
	
	
	@GetMapping("/detail_view")
	public String detailView(
			@RequestParam("id") int id
			, Model model
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		
		PostDetail postDetail = postBO.getPostList(userId, id);
		model.addAttribute("postDetail", postDetail);
		
		Post post = postBO.getPost(id);
		model.addAttribute("post", post);
		
		return "post/detailView";
	}
	
	
}
