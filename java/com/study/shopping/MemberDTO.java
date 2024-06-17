package com.study.shopping;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MemberDTO {
	int id;
	String user_id;
	String password;
	String name;
	String nickname;
	String mobile;
	String mail;
	String birth;
	String gender;
	String join_day;
	String out_day;
	String zipcode;
	String adress;
	String adress2;
	int member_rank;
	String salt;

}