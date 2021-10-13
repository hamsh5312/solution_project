package com.hamsh5312.solution.Wpost.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hamsh5312.solution.Wpost.dao.W_PostDAO;
import com.hamsh5312.solution.common.FileManagerService;

@Service
public class W_PostBO {
	
	@Autowired
	private W_PostDAO w_postDAO;
	
	public int addPost(int userId, String userName, String subject, String content, MultipartFile file, String sBox) {
		
		String imagePath = null;
		// 파일이 있을경우에만 저장 로직 진행
		if(file != null) {
			imagePath = FileManagerService.saveFile(userId, file);
			// saveFile에서 파일 저장에 실패한 경우
			if(imagePath == null) {
				return 0;
			}
		}
		
		return w_postDAO.insertWPost(userId, userName, subject, content, imagePath, sBox);
		
	}
	
}
