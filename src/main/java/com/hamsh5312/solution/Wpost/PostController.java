package com.hamsh5312.solution.Wpost;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/post")
public class PostController {


	@GetMapping("/create_worry_view")
	public String createWorryView() {
		return "post/worryCreateView";
	}
	
	@GetMapping("/worry_detail_view")
	public String worryDetail() {
		return "post/worryDetailView";
	}
	
}
