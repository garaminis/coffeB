package com.study.shopping;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;

 
@Service
@AllArgsConstructor
public class EmailService {
 
    private JavaMailSender EmailSender;
 
    public void sendSimpleMessage(String code,String mail) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("bbo9703@naver.com"); //받는메일??? 
//        message.setTo(mailDto.getAddress());  //보내는이메일
        message.setTo(mail);  //보내는이메일
//        message.setSubject(mailDto.getTitle()); //메일 제목
        message.setSubject("메일인증번호"); //메일 제목
//        message.setText(mailDto.getContent()); //메일 내용
        message.setText("저희 사이트를 방문해주셔 감사합니다 인증번호는 "+code+" 입니다"); //메일 내용
        EmailSender.send(message);
        
        
        
        
        
    }
}
