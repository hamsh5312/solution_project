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
import com.hamsh5312.solution.user.model.User;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private RecommendBO recommendBO;
	
	@GetMapping("/create_view")
	public String create() {
		return "post/createView";
	}
	
	@GetMapping("/list_view")
	public String listView(
			Model model
			, @RequestParam(value= "page" , required = false) Integer page
			, @RequestParam(value ="category", required =false) String category
			) {
		// 파라미터 추가해서 옵션을위한.. 공부인지 음악인지  필수가 아닌거를 설정
		
		
		PageMaker pageMaker = new PageMaker();
		Criteria cri = new Criteria();
		if(page != null) {
			cri.setPage(page);
//			cri.setPerPageNum(perPageNum);
			
		}
		
		String categoryStatus = category;
		String sBox;
		if(categoryStatus == null) {
			 sBox = "all";
		}else {
			sBox = category;
		}
		pageMaker.setCri(cri);
		
		// setTotalCount 에 넣는 숫자를 계산해보자
		// 일단 int 형 변수를 만들고 거기에 값을 넣어서 전달하는거야
		int number = postBO.countNumber(sBox);
		// 위 number 를 아래에 100대신 대입하자
		
		pageMaker.setTotalCount(number);
		
		
		List<Post> worryList = postBO.getWorryList(pageMaker, sBox);
		
		model.addAttribute("worryList", worryList);
		model.addAttribute("pageMaker", pageMaker);
		
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
		
		List<Recommend> recommendList = recommendBO.getRecommendRankingList();
		
		model.addAttribute("recommendList", recommendList);
		
		
				
		return "post/rankingView";
	}
	
	
	
}
