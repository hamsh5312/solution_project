package com.hamsh5312.solution.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.hamsh5312.solution.common.FileManagerService;
import com.hamsh5312.solution.common.PermissionInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{

	@Autowired
	private PermissionInterceptor permissionInterceptor;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// 서버(내 컴퓨터) 의 특정 위치의 파일들을
		// 내가 정한 url path로 접근하게 하는 설정
		registry.addResourceHandler("/images/**")     // images/3_3295124124/test.png
		.addResourceLocations("file:" + FileManagerService.FILE_UPLOAD_PATH);
		
		//.addResourceLocations("file:///" + FileManagerService.FILE_UPLOAD_PATH);
		
//		.addResourceLocations("file:" + FileManagerService.FILE_UPLOAD_PATH);
		
// 위에는  서버 경로 파일인거고  아래는 내 로컬 서버에 있는 파일경로이다. 이거를 수정해서 FileManagerService 쪽가서도 대응하여 수정
		
		//  .addResourceLocations("file:///" + FileManagerService.FILE_UPLOAD_PATH);
		
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(permissionInterceptor)
		.addPathPatterns("/**")  // 어느 path의 접근을 낚아 챌지
		.excludePathPatterns("/static/**", "/user/sign_out");
	}
	
	
	
}
