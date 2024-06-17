package com.study.shopping;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GoodsDTO {
	int id;
	String userid;
	int order_id;
	int state_id;
	String state_name;
	int category_id;
	int category;
	String title;
	String name;
	String date;
	int price;
	int stock;
	int delivery;
	String img1;
	String img2;
	String img3;
	String img4;
	String img5;
	String content;
	String delpay;
	int pay;
	int cart_id;
	int cnt;
	String mobile;
	String mail;
	String member_name;
	String del_name;
	int total;
	String user_id;
	int member_id;
	int goods_id;
	int g_id;
	private MultipartFile image;
	int discnt;
	int review_id;
	int group_id;
}
