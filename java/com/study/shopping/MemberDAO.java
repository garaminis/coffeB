package com.study.shopping;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDAO {
	ArrayList<MemberDTO> list();
}
