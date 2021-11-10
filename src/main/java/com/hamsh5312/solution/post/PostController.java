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
			, @RequestParam(value = "NotCount", required =false) Integer NotCount
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
		
		// 날짜 확인해보기
		SimpleDateFormat dtf = new SimpleDateFormat("yyyy-MM");
        Calendar calendar = Calendar.getInstance();

        Date dateObj = calendar.getTime();
        String formattedDate = dtf.format(dateObj);
        String startDate = formattedDate + "-01 00:00:00";
        String endDate = formattedDate + "-" + calendar.getActualMaximum(Calendar.DAY_OF_MONTH) + " 23:59:59";		
        //System.out.println(formattedDate);
		// formattedDate 에는 2021-11 이 저장 되어있다고 판단함.. 확인은?
		
		// 날짜 정보를 출력해보자
        String dateInfo = recommendBO.chooseBonusPeople(startDate, endDate);
		model.addAttribute("dateInfo",dateInfo);
		
		// 상품 수령할 수 있는 1등부터 4등까지의 4명의 정보를 List<User> 의 productReceiveList 변수를 만들 때 조건을
		// 그 productReceiveList에 파라미터값으로 총 4개를 입력해주자. 
		// top5People.get(0), top5People.get(0), top5People.get(0), top5People.get(0) 이렇게 4개의 파라미터를 전달
		// 그래서 그 리스트결과를 모델로 넘겨주어서 jsp 쪽에서 하나씩 그 리스트에서 이메일정보를 뽑아서 " ~님 ~이메일에서 상품 안내정보를 확인하세요"
		
		return "post/productView";
		
		
	}
	
	
	
	
}
