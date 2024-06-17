package com.study.shopping;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GoodsDAO {
	int goodsAdd(int Category_id, String title, int price,int discnt, int stock, int delivery, String content, List<String> img);
	ArrayList<GoodsDTO> itemList(int id, int start, int end);
	ArrayList<GoodsDTO> search(String a);
	ArrayList<GoodsDTO> itemInfo(int id);
	ArrayList<GoodsDTO> list();
	ArrayList<GoodsDTO> tkcategory();
	int upd(int id, int category,String title,int price, int stock,int delivery,int discnt);
	GoodsDTO view(int x);
	int remove(int x);
	ArrayList<GoodsDTO> getCart(String id);
	ArrayList<GoodsDTO> getOrderList(int id);
	int updateState(int x);
	GoodsDTO cartOrder(int a);
	int addCart(int a, int b, int c);
	int getIdNum(String a);
	int checkCart(int a, int b);
	int delCart(int value);
	int updateCart(int a, int b);
	int addOrder(int a, String b, String c, String d);
	int addReviewId(int a,int b);
}
