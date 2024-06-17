package com.study.shopping;

import lombok.Data;

@Data
public class BoardDTO {
	int id;
	int category;
	String title;
	String content;
	String writer;
	String created;
	String nickname;

}
