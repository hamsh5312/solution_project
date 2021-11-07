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
	
	
	public List<Post> getSearchWorryList(PageMaker pageMaker, String searchInput){
		
		int pageStart = pageMaker.getCri().getPageStart();
		int perPageNum = pageMaker.getCri().getPerPageNum();
		
		return postDAO.selectSearchWorryList(pageStart, perPageNum, searchInput);
	}
	
	
	public List<Post> getMyWorryList(PageMaker myPageMaker, int userId){
		
		int pageStart = myPageMaker.getCri().getPageStart();
		int perPageNum = myPageMaker.getCri().getPerPageNum();
		
		return postDAO.selectMyWorryList(pageStart, perPageNum, userId);
	}
	
	public int countNumber(String category) {
		return postDAO.selectNumber(category);
	}
	
	public int countSearchInput(String searchInput) {
		return postDAO.selectSearchInput(searchInput);
	}
	
	public int countMyNumber(int userId) {
		return postDAO.selectMyNumber(userId);
	}
	
	public Post getPost(int id) {
		return postDAO.selectPost(id);
	}
	
	// 조회수
	public void increasePostHit(int id) {
		postDAO.increasePostHit(id);
	}
	
	// 찜 한거 postId 총 몇개인 가져오자
	public int countLikePost(int userId) {
		return postDAO.selectLikePost(userId);
	}
	
	// 찜 한거 postId 가져오자
	public List<Integer> likePostIdByUserId(Integer userId){
		return postDAO.selectLikePostIdByUserId(userId);
	}
	
	// 찜목록 가져오자
	public List<Post> getLikePostList(PageMaker myPageMaker, Integer userId){
		
		List<Integer> likePostIdList = likePostIdByUserId(userId);
		
		int pageStart = myPageMaker.getCri().getPageStart();
		int perPageNum = myPageMaker.getCri().getPerPageNum();
		
		return postDAO.selectLikeWorryList(pageStart, perPageNum, likePostIdList);
	
		
	}
	
	
	// 고민내용 삭제하기전 해당 포스트를 쓴 사람만 삭제하도록하기위해서 게시물 체크
	public Post postDeleteCheck(int id, int userId) {
		return postDAO.selectDeletePost(id, userId);
	}
	
	// post 삭제중 찜(like) 삭제
	public int deleteLikeByPostId(int postId) {
		return postDAO.deleteLikeByPostId(postId);
	}
	
	
	// post 삭제  ( post 삭제, 찜(like) 삭제, 댓글 삭제 , 추천 삭제 )
	public int deletePost(int postId, int userId) {
		
		Post post = this.postDeleteCheck(postId, userId);
		
		if(post.getImagePath() != null) {
			FileManagerService.removeFile(post.getImagePath());
		}
		
		// 댓글, 추천, 찜 삭제 
		// 우선 postId 를 넣어주었을때 그에 맞는 댓글 리스트를 뽑아오자
		List<Comment> commentList = commentBO.getCommentListByPostId(postId);
		// recommend 전체 반복을 돌리다가 하나하나씩 비교해봐 또하나의 commentList 반복문으로
		// 추천리스트 뽑아 오자
		List<Recommend> recommendList = recommendBO.getRecommendList();
		
		for(Recommend recommend : recommendList) {
			
			for(Comment comment : commentList) {
				
				if(recommend.getCommentId() == comment.getId()) {
					int commentId = comment.getId();
					recommendBO.deleteRecommendByCommentId(commentId);
				}
				
			}
			
		}
		
		// 댓글 삭제  찜 삭제
		commentBO.deleteCommentByPostId(postId);
		deleteLikeByPostId(postId);
		
		
		return postDAO.deletePost(postId, userId);
	}
	
	
	
	
	public int updatePost(int id, int userId, String subject, String content) {
		return postDAO.updatePost(id, userId, subject, content);
	}
	
	// 조회수
	public void increasePostHit(int id) {
		postDAO.increasePostHit(id);
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
		
		boolean isLike = likeByUserIdPostId(post.getId(), userId);
		postDetail.setLike(isLike);
		
		postDetail.setPost(post);
		postDetail.setCommentDetailList(commentDetailList);
			
		return postDetail;
	}
	
	// 찜 관련 메소드
	public boolean likeByUserIdPostId(int postId, int userId) {
		int count = postDAO.selectCountLikeByUserIdPostId(postId, userId);
		
		if(count == 0) {
			return false;
		}else {
			return true;
		}	
	}
	
	public boolean like(int userId, int postId) {
			
			// 찜 상태면 찜 취소
			if(this.likeByUserIdPostId(postId, userId)) {
				int count = postDAO.deleteLike(userId, postId);
				if(count == 0) {
					return false;
				}else {
					return true;
				}
			}else {  // 찜 취소 상태면 찜
				int count = postDAO.insertLike(userId, postId);
				if(count == 1) {
					return true;
				}else {
					return false;
				}
			}
			
		}
	
	
	//
	
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
