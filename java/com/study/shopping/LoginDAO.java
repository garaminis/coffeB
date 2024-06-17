package com.study.shopping;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {
	
	String getApiName(String user_id); //API로그인 닉네임만 가져옴

	int idchk(String user_id); // 아이디 중복 체크

	int doApiSignup(String userId, String nickname, String pws, String name, String mobile, String mail,
			String birth, String gender, String zipcode, String adress, String adress2);
	
	int add(String userId, String psw, String name, String mobile, String mail, String birth, String adress,
			String zipcode, String gender, String adress2, String nickname, String salt);// 회원가입 db insert

	MemberDTO getSalt(String user_id);
	
	int dologin(String id, String psw); // login 하기
	

	String  getNickname(String user_id, String pw_decrypt);

	int adlogin(String user_id, String passwd);

	MemberDTO getEmail(String mail);

	int Nicknamechk(String userNickname);

	int id_mail_chk(String mail, String id);

	int updatePass(String id, String pw_encrypt, String salt); 




}