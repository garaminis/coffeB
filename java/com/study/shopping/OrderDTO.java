package com.study.shopping;

import lombok.Data;

@Data
public class OrderDTO {
	int id;
	int order_id;
	String member_id;
	String user_id;
	String goods_name;
	int cnt;
	int sales;
	String delname;
	String delzipcode;
	String deladress;
	String deladress2;
	String delmobile;
	String delreq;
	String delivery_name;
	String payment_name;
	String orderstate_name;
	String order_state_name;
	int delivery_pay;
	int state;
	String created;
}
