package com.board.domain;

import java.util.Date;

public class MemberVO {

/*
  `userId` varchar(30) NOT NULL,
  `userPw` varchar(100) NOT NULL,
  `userName` varchar(30) NOT NULL,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
*/
	private String userId;
	private String userPw;
	private String userName;
	private Date regDate;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}	
	
}
