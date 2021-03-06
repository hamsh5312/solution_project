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
	
	// ?????????
	public void increasePostHit(int id) {
		postDAO.increasePostHit(id);
	}
	
	// ??? ?????? postId ??? ????????? ????????????
	public int countLikePost(int userId) {
		return postDAO.selectLikePost(userId);
	}
	
	// ??? ?????? postId ????????????
	public List<Integer> likePostIdByUserId(Integer userId){
		return postDAO.selectLikePostIdByUserId(userId);
	}
	
	// ????????? ????????????
	public List<Post> getLikePostList(PageMaker myPageMaker, Integer userId){
		
		List<Integer> likePostIdList = likePostIdByUserId(userId);
		int pageStart = myPageMaker.getCri().getPageStart();
		int perPageNum = myPageMaker.getCri().getPerPageNum();
		
		return postDAO.selectLikeWorryList(pageStart, perPageNum, likePostIdList);
	}
	
	
	// ???????????? ???????????? ??? ?????? ???????????? ??? ????????? ??????????????? ?????? ????????? ????????? ??????
	public Post postDeleteCheck(int id, int userId) {
		return postDAO.selectDeletePost(id, userId);
	}
	
	// post ????????? ???(like) ??????
	public int deleteLikeByPostId(int postId) {
		return postDAO.deleteLikeByPostId(postId);
	}
	
	
	// post ??????  ( post ??????, ???(like) ??????, ?????? ?????? , ?????? ?????? )
	public int deletePost(int postId, int userId) {
		
		Post post = this.postDeleteCheck(postId, userId);
		
		if(post.getImagePath() != null) {
			FileManagerService.removeFile(post.getImagePath());
		}
		
		// ??????, ??????, ??? ?????? 
		// ?????? postId ??? ?????????????????? ?????? ?????? ?????? ???????????? ????????????
		List<Comment> commentList = commentBO.getCommentListByPostId(postId);
		// recommend ?????? ????????? ???????????? ??????????????? ???????????? ??? ????????? commentList ???????????????
		// ??????????????? ?????? ??????
		List<Recommend> recommendList = recommendBO.getRecommendList();
		
		for(Recommend recommend : recommendList) {
			for(Comment comment : commentList) {
				if(recommend.getCommentId() == comment.getId()) {
					int commentId = comment.getId();
					// ?????? ??????
					recommendBO.deleteRecommendByCommentId(commentId);
				}	
			}
		}
		
		// ?????? ??????  ??? ??????
		commentBO.deleteCommentByPostId(postId);
		deleteLikeByPostId(postId);
		
		return postDAO.deletePost(postId, userId);
	}
	
	
	public int updatePost(int id, int userId, String subject, String content) {
		return postDAO.updatePost(id, userId, subject, content);
	}
	
	
	public PostDetail getPostList(Integer userId, int postId){
		
		Post post = postDAO.selectWorry(postId);
		PostDetail postDetail = new PostDetail();
		
		List<CommentDetail> commentDetailList = new ArrayList<>();
		
		// ???????????? ???????????? ?????? ????????????
		List<Comment> commentList = commentBO.getCommentListByPostId(post.getId());
		
		for(Comment comment : commentList) {
			CommentDetail commentDetail = new CommentDetail();
			// ?????? ???????????? ?????? ????????? ?????? ??????
			int recommendCount = recommendBO.recommendCount(comment.getId());
			
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
	
	// ??? ?????? ?????????
	public boolean likeByUserIdPostId(int postId, int userId) {
		int count = postDAO.selectCountLikeByUserIdPostId(postId, userId);
		
		if(count == 0) {
			return false;
		}else {
			return true;
		}	
	}
	
	
	public boolean like(int userId, int postId) {
			
		// ??? ????????? ??? ??????
		if(this.likeByUserIdPostId(postId, userId)) {
			int count = postDAO.deleteLike(userId, postId);
			if(count == 0) {
				return false;
			}else {
				return true;
			}
		}else {  // ??? ?????? ????????? ???
			int count = postDAO.insertLike(userId, postId);
			if(count == 1) {
				return true;
			}else {
				return false;
			}
		}
		
	}
	
	
	public List<User> getUserList(){ 
		return userDAO.selectUser();
	}
	
	public List<CommentDetail> getCommentDetailList(){
		
		List<Comment> commentList = commentBO.getCommentList();
		List<CommentDetail> commentDetailList = new ArrayList<>();
		
		// ?????? ????????? ?????? ??????, ?????? ?????? ????????????
		for(Comment comment : commentList) {
			
			int recommendCount = recommendBO.recommendCount(comment.getId());
			
			// comment ??? ????????? ??????
			CommentDetail commentDetail = new CommentDetail();
			commentDetail.setComment(comment);
			
			// ???????????? comment??? ?????? ???????????? ???????????? ??????????????? ??????
			
			// ????????? ?????? ????????? ?????????????????? (?????? ?????? ????????? ???????????? ??????????????? ????????????)
			boolean isRecommend = false;
			commentDetail.setRecommend(isRecommend);		
			commentDetail.setRecommendCount(recommendCount);
	
			commentDetailList.add(commentDetail);
			
		}
		
		return commentDetailList;
		
	}
	
	
	public List<RecommendInfo> getRecommendInfoList(){
		
		List<Recommend> recommendList = recommendBO.getRecommendRankingList();
		List<RecommendInfo> recommendInfoList = new ArrayList<>();
		List<Integer> personTotalRecommendList = recommendBO.getRecommendTotalCount();
		
		int i = 0;
		for(Recommend recommend : recommendList) {

			RecommendInfo recommendInfo = new RecommendInfo();
			recommendInfo.setRecommend(recommend);
			
			for( ; i < personTotalRecommendList.size(); ) {
		
				recommendInfo.setPersonTotalRecommend(personTotalRecommendList.get(i));
				i++;
				break;	
			}
			
			recommendInfoList.add(recommendInfo);
		}
		
		return recommendInfoList;
			
	}
	
	
	
}
