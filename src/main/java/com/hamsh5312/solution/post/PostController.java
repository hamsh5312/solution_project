package com.hamsh5312.solution.post;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
		
		List<Post> worryList = postBO.getMyWorryList(myPageMaker, userId);
		model.addAttribute("worryList", worryList);
		// post/myView 에서 post/listView 로 바꿈
		return "post/listView";
	}
	
	
	@GetMapping("/my_like_view")
	public String likeView(
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
		
		int likeNumber = postBO.countLikePost(userId);
		
		myPageMaker.setTotalCount(likeNumber);
		model.addAttribute("pageMaker", myPageMaker);
		
		List<Post> worryList = postBO.getLikePostList(myPageMaker, userId);
		model.addAttribute("worryList", worryList);
		
		return "post/listView";
	}
	
	
	@GetMapping("/detail_view")
	public String detailView(
			@RequestParam("id") int id
			, @RequestParam(value = "NotCount", required = false) Integer NotCount
			, Model model
			, HttpServletRequest request) {
		
		
		if(NotCount == null) {
			postBO.increasePostHit(id);
		}
		
				
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		
		String userName = (String)session.getAttribute("userName");
		model.addAttribute("userName", userName);
		
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
		
		List<User> userList = postBO.getUserList();
		model.addAttribute("userList", userList);
		
		List<RecommendInfo> recommendInfoList = postBO.getRecommendInfoList();
		model.addAttribute("recommendInfoList", recommendInfoList);
				
		return "post/rankingView";
	}
	
	
	@GetMapping("/product_view")
	public String productView(Model model) {
		
		List<String> top3People = recommendBO.getTop3People();
		model.addAttribute("top3People",top3People);
		
		List<Recommend> top5People = recommendBO.getRecommendRankingList();
		model.addAttribute("top5People",top5People);
		
		// 날짜 확인해보기
		SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM");
        Calendar calendar = Calendar.getInstance();

        Date dateObj = calendar.getTime();
        String formattedDate = dtf.format(dateObj);
        String startDate = formattedDate + "-01 00:00:00";
        String endDate = formattedDate + "-" + calendar.getActualMaximum(Calendar.DAY_OF_MONTH) + " 23:59:59";		
        
		// 날짜 정보를 출력해보자
        String dateInfo = recommendBO.chooseBonusPeople(startDate, endDate);
		model.addAttribute("dateInfo",dateInfo);
		
		return "post/productView";
		
	}
	
	
}
