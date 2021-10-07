package com.hamsh5312.ex.hello;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {
	
	@ResponseBody
	@RequestMapping("/hello")
	public String helloworld() {
		return "hello world";
	}
	
	
}
