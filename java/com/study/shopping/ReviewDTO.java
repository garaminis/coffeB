package com.study.shopping;

import lombok.Data;

@Data
public class ReviewDTO {
	int id;
	int rating;
	String user_id;
	String created;
	String content;
	String name;
	String qwriter;
	String awriter;
	String qusdate;
	String answer;
	String ansdate;
	String title;
	int state;
	int member_id;
}


