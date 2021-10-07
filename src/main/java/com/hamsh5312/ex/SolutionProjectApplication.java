package com.hamsh5312.ex;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication
@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
public class SolutionProjectApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(SolutionProjectApplication.class, args);
	}
	
}
