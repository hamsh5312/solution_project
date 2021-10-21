package com.hamsh5312.solution.post.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hamsh5312.solution.common.FileManagerService;
import com.hamsh5312.solution.post.comment.bo.CommentBO;
import com.hamsh5312.solution.post.comment.model.Comment;
import com.hamsh5312.solution.post.comment.model.CommentDetail;
import com.hamsh5312.solution.post.dao.PostDAO;
import com.hamsh5312.solution.post.model.Post;
import com.hamsh5312.solution.post.model.PostDetail;
import com.hamsh5312.solution.post.recommend.bo.RecommendBO;

@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private RecommendBO recommendBO;
	
	
	public int addPost(int userId, String userName, String subject, String content, MultipartFile file, String sBox) {
		
		String filePath = FileManagerService.saveFile(userId, file);
		
		if(filePath == null) {
			return -1;
		}
		
		return postDAO.insertPost(userId, userName, subject, content, filePath, sBox);
	}
	
	
	public List<Post> getWorryList(){
		return postDAO.selectWorryList();
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
	
	
	
	
//	public boolean deletePost(int id, int userId) {
//		// 아래 id 에 실질적으로 postId 가 전달된다.
//		Post post = this.getPost(id, userId);
//		
//		int count = postDAO.deletePost(id, userId);
//		if(count != 1) {
//			return false;
//		}
//		
//		FileManagerService fileManagerService = new FileManagerService();
//		fileManagerService.removeFile(post.getImagePath());
//		
//		// 댓글, 추천 삭제 
//		commentBO.deleteCommentByPostId(id);
//		recommendBO.deleteRecommendByPostId(id);
//		
//		return true;
//	}

	
	
	
}
