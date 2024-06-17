package com.study.shopping;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderDAO {
	ArrayList<OrderDTO> list(int x);
	int updatestate(int a, int b);
	ArrayList<OrderDTO> orderlist(int x);
}
