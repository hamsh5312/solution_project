package com.hamsh5312.solution.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.web.multipart.MultipartFile;

public class FileManagerService {

//	public final static String FILE_UPLOAD_PATH = "C:\\springMarondalAnswer\\TestAnswer\\solutionProject_upload\\images/";  
	public final static String FILE_UPLOAD_PATH = "/home/ec2-user/uploads";
		
	public static String saveFile(int userId, MultipartFile file) {
		// 파일 경로
		// 1.올린사람의 id로 구분해서 저장
		// 2.올린 시간을 기준으로 구분한다.
		//  /43_281281298129/test.png
		// 1970년 1월1일을 기준으로 몇 밀리초(1/1000)가 지났는지
		
//		Logger logger = LoggerFactory.getLogger(this.getClass());
		
		//43_281281298129/
		String directoryName = userId + "_" + System.currentTimeMillis() + "/";
		
		//C:\\springTest\\upload\\images/43_281281298129/
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		// 디렉토리 생성
		File directory = new File(filePath);
		// make directory 메소드 호출
		if(directory.mkdir() == false) {
			// 디렉토리 생성 에러
//			logger.error("[FileManagerService saveFile] 디렉토리 생성 에러");
			return null;
		}
		
		// byte[]
		try {
			byte[] bytes = file.getBytes();
			// 파일 경로
			Path path = Paths.get(filePath + file.getOriginalFilename());
			// 파일 저장
			Files.write(path, bytes);
			
		} catch (IOException e) {
//			logger.error("[FileManagerService saveFile] 파일 생성 실패");
			e.printStackTrace();
			return null;
		}
		
		
		// 파일을 접근할수 있는 경로
		// <img src="/images/43_281281298129/test.png">
		
		return "/images/" + directoryName + file.getOriginalFilename();
		
	}
	
	
	
	public static void removeFile(String filePath) {
		// filePath
		// post 테이블에 있는 imagePath
		// ex > /images/1-201020123/test.png
		// 실제 경로 ex > C:\\springTest\\upload\\images\1-201020123\test.png

		String realFilePath = FILE_UPLOAD_PATH + filePath.replace("/images/", "");
		Path path = Paths.get(realFilePath);
		if(Files.exists(path)) {
			try {
				Files.delete(path);
			} catch(IOException e) {
				e.printStackTrace();
			}
			
		}
		// 디렉토리(폴더) 삭제
		// C:\\springTest\\upload\\images\1-201020123
		path = path.getParent();
		if(Files.exists(path)) {
			try {
				Files.delete(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	
}
