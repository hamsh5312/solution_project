package com.hamsh5312.solution.post.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hamsh5312.solution.common.FileManagerService;
import com.hamsh5312.solution.common.PageMaker;
import com.hamsh5312.solution.post.comment.bo.CommentBO;
import com.hamsh5312.solution.post.comment.model.Comment;
import com.hamsh5312.solution.post.comment.model.CommentDetail;
import com.hamsh5312.solution.post.dao.PostDAO;
import com.hamsh5312.solution.post.model.Post;
import com.hamsh5312.solution.post.model.PostDetail;
import com.hamsh5312.solution.post.recommend.bo.RecommendBO;
import com.hamsh5312.solution.post.recommend.model.Recommend;
import com.hamsh5312.solution.post.recommend.model.RecommendInfo;
import com.hamsh5312.solution.user.dao.UserDAO;
import com.hamsh5312.solution.user.model.User;

@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private RecommendBO recommendBO;
	
	@Autowired
	private UserDAO userDAO;
	
	
	public int addPost(int userId, String userName, String subject, String content, MultipartFile file, String sBox) {
		
		String filePath = FileManagerService.saveFile(userId, file);
		
		if(filePath == null) {
			return -1;
		}
		
		return postDAO.insertPost(userId, userName, subject, content, filePath, sBox);
	}
	
	
	public List<Post> getWorryList(PageMaker pageMaker, String sBox){
		
		int pageStart = pageMaker.getCri().getPageStart();
		int perPageNum = pageMaker.getCri().getPerPageNum();
		
		return postDAO.selectWorryList(pageStart, perPageNum, sBox);
	}
	
	public int countNumber(String category) {
		return postDAO.selectNumber(category);
	}
	
	public Post getPost(int id) {
		return postDAO.selectPost(id);
	}
	
	
	// 고민내용 삭제하기전 해당 포스트를 쓴 사람만 삭제하도록하기위해서 게시물 체크
	public Post postDeleteCheck(int id, int userId) {
		return postDAO.selectDeletePost(id, userId);
	}
	
	
	public int deletePost(int postId, int userId) {
		
		Post post = this.postDeleteCheck(postId, userId);
		
		if(post.getImagePath() != null) {
			FileManagerService.removeFile(post.getImagePath());
		}
		
		return postDAO.deletePost(postId, userId);
	}
	
	
	public int updatePost(int id, int userId, String subject, String content) {
		return postDAO.updatePost(id, userId, subject, content);
	}
	
	
	
	public PostDetail getPostList(Integer userId, int postId){
		
		Post post = postDAO.selectWorry(postId);
		PostDetail postDetail = new PostDetail();
		
		List<CommentDetail> commentDetailList = new ArrayList<>();
		
		// 해당하는 포스트의 댓글 가져오기
		List<Comment> commentList = commentBO.getCommentListByPostId(post.getId());
		
		for(Comment comment : commentList) {
			CommentDetail commentDetail = new CommentDetail();
			// 해당 포스트에 추천 개수
			int recommendCount = recommendBO.recommendCount(comment.getId());
			
			// 추가로 비오에서 해당댓글에 추천한기록있는지 가져오기 그담에 넣기
			// 아래 userId 로 되어있는거 변수명도 commentId 로 바꾸고 파라미터값도 조정바람
			boolean isRecommend = recommendBO.recommendByCommentIdUserId(comment.getId(), userId);
			commentDetail.setComment(comment);
			commentDetail.setRecommendCount(recommendCount);
			commentDetail.setRecommend(isRecommend);
			
			commentDetailList.add(commentDetail);
		}
		
		postDetail.setPost(post);
		postDetail.setCommentDetailList(commentDetailList);
			
		return postDetail;
	}
	
	
	public List<User> getUserList(){ 
		return userDAO.selectUser();
	}
	
	public List<CommentDetail> getCommentDetailList(){
		
		// 바로 아래식은 굳이 필요없을거같은데... 내가 필요한건 추천개수뿐임.
		List<Comment> commentList = commentBO.getCommentList();
		List<CommentDetail> commentDetailList = new ArrayList<>();
		
		// 댓글 하나당 추천 상태, 추천 개수 매칭하기
		for(Comment comment : commentList) {
			
			int recommendCount = recommendBO.recommendCount(comment.getId());
			
			// comment 와 나머지 매칭
			CommentDetail commentDetail = new CommentDetail();
			commentDetail.setComment(comment);
			
			// 해당하는 comment를 현재 로그인한 사용자가 추천했는지 확인
			
			// 어차피 아래 상태는 필요없으니까 (고민 해결 순위에 아이디별 추천상태는 필요없음, 화면에 안타나남)
			boolean isRecommend = false;
			commentDetail.setRecommend(isRecommend);		
			commentDetail.setRecommendCount(recommendCount);
	
			commentDetailList.add(commentDetail);
			
		}
		
		return commentDetailList;
		
	}
	
	
	public List<RecommendInfo> getRecommendInfoList(){
		
		// 포스트 컨트롤러에서 아래 식이 있었음.. 활용하기
//		List<Recommend> recommendList = recommendBO.getRecommendRankingList();
		
		List<Recommend> recommendList = recommendBO.getRecommendRankingList();
		List<RecommendInfo> recommendInfoList = new ArrayList<>();
		List<Integer> personTotalRecommendList = recommendBO.getRecommendTotalCount();
		
		int i = 0;
		for(Recommend recommend : recommendList) {
			// Recommend 리스트들을 하나씩 set 하자
			RecommendInfo recommendInfo = new RecommendInfo();
			recommendInfo.setRecommend(recommend);
			
			// 전체 추천수를  set 하자
			
			for( ; i < personTotalRecommendList.size(); ) {
				// 여기에 어떤 조건을 주어서 하나씩만 set 하고싶은데... 아래방법이 맞는건가 ... 음
				recommendInfo.setPersonTotalRecommend(personTotalRecommendList.get(i));
				i++;
				break;	
			}
			
			recommendInfoList.add(recommendInfo);
		}
		
		return recommendInfoList;
			
	}
	
	
	
	
}
