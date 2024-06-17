package com.study.shopping;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
 
@Getter
@Setter
@NoArgsConstructor
public class MailDTO {
    private String address;
    private String title;
    private String content;
    private String FromAdress;
    private String code;
    private String mail;
}
