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
import com.hamsh5312.solution.post.recommend.bo.RecommendBO;
import com.hamsh5312.solution.post.recommend.model.Recommend;
import com.hamsh5312.solution.post.recommend.model.RecommendInfo;
import com.hamsh5312.solution.user.model.User;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired RecommendBO recommendBO;
	
	@GetMapping("/create_view")
	public String create() {
		return "post/createView";
	}
	
	
	@GetMapping("/list_view")
	public String listView(
			Model model
			, @RequestParam(value= "page" , required = false) Integer page
			, @RequestParam(value ="category", required =false) String category
			, @RequestParam(value ="searchInput", required =false) String searchInput
			//, RedirectAttributes redAttr
			) {
		
		PageMaker pageMaker = new PageMaker();
		Criteria cri = new Criteria();
		if(page != null) {
			cri.setPage(page);
		}
		pageMaker.setCri(cri);
		
		if(searchInput != null) {
			// 검색어가 뭔가 들어오면
			int searchNumber = postBO.countSearchInput(searchInput);
			pageMaker.setTotalCount(searchNumber);
			model.addAttribute("pageMaker", pageMaker);
			List<Post> worryList = postBO.getSearchWorryList(pageMaker, searchInput);
			model.addAttribute("worryList", worryList);
			
		}else {
			String categoryStatus = category;
			String sBox;
			if(categoryStatus == null) {
				 sBox = "all";
			}else {
				sBox = category;
			}
			
			int number = postBO.countNumber(sBox);
			pageMaker.setTotalCount(number);
			model.addAttribute("pageMaker", pageMaker);
			
			List<Post> worryList = postBO.getWorryList(pageMaker, sBox);
			model.addAttribute("worryList", worryList);
		}

		return "post/listView";
	}
	
	
	@GetMapping("/my_view")
	public String myView(
			Model model
			, @RequestParam(value= "page" , required = false) Integer page
			, HttpServletRequest request) {
		
		PageMaker myPageMaker = new PageMaker();
		Criteria cri = new Criteria();
		if(page != null) {
			cri.setPage(page);
		}
		myPageMaker.setCri(cri);
		
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		
		int myNumber = postBO.countMyNumber(userId);
		myPageMaker.setTotalCount(myNumber);
		model.addAttribute("pageMaker", myPageMaker);
		
		List<Post> myWorryList = postBO.getMyWorryList(myPageMaker, userId);
		model.addAttribute("myWorryList", myWorryList);
		
		return "post/myView";
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
	
	
	@GetMapping("/ranking_view")
	public String rankingView(
			Model model
			) {
		// 일단 user 테이블을 전체 다 선택하는 메소드가 필요
		// 
		List<User> userList = postBO.getUserList();
		
//		List<CommentDetail> commentDetailList = postBO.getCommentDetailList();
		
		model.addAttribute("userList", userList);
		// 그냥, 추천 테이블을 샐랙트하고,  JSP 로 넘어간 그 쪽에서는 
		// 그쪽에서는... recommend 테이블에서는 
		// commentCreateUserName  별 SELECT count(commentId) 하고  뒤이어 끝에
		// ORDER BY `count(commentId)` DESC
		// 위와같이 정렬을 하고 화면에 보이는거는
		// userList에서 반복문으로 user의 name 이 commentCreateUserName 하고 같을때 
		// user.introduce (해결사의 한마디 !) 출력
		// recommend 테이블의 commentCreateUserName(작성자) 출력하고 commendId 개수(추천 개수) 출력하고
		
//		List<Recommend> recommendList = recommendBO.getRecommendRankingList();
		List<RecommendInfo> recommendInfoList = postBO.getRecommendInfoList();
		model.addAttribute("recommendInfoList", recommendInfoList);
				
		return "post/rankingView";
	}
	
	
	
	@GetMapping("/product_view")
	public String productView(
			Model model) {
		
		List<String> top3People = recommendBO.getTop3People();
		
		model.addAttribute("top3People",top3People);
		
		
		List<Recommend> top5People = recommendBO.getRecommendRankingList();
		model.addAttribute("top5People",top5People);
		
		return "post/productView";
		
	}
	
	
	
	
}
