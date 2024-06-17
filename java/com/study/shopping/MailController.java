package com.study.shopping;

import com.study.shopping.MailDTO;

import jakarta.servlet.http.HttpServletRequest;

import com.study.shopping.EmailService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
 
@Controller
public class MailController {
 
    private final EmailService emailService;
 
    public MailController(EmailService emailService) {
        this.emailService = emailService;
    }
 
    @GetMapping("SendMail_Jin")
    public String main() {
        return "SendMail_Jin";
    }
    @GetMapping("send2")
    public String main2() {
    	return "SendMail2";
    }
 
    @PostMapping("/mail/send")
    public String sendMail(HttpServletRequest req) {
        emailService.sendSimpleMessage(req.getParameter("code"),req.getParameter("mail"));
        System.out.println("메일 전송 완료");
        return "";
    }
}