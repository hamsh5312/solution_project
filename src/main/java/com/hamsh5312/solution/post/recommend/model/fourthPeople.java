package com.hamsh5312.solution.post.recommend.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class fourthPeople {

	private int id;
	private String fourthUserName;
	private String product;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createdAt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFourthUserName() {
		return fourthUserName;
	}
	public void setFourthUserName(String fourthUserName) {
		this.fourthUserName = fourthUserName;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	
	
	
	
}
