package com.spring.hs.dto;

public class MemberConnectDTO {
	private int c_no;
	private String c_code;
	private String u1;
	private String u2;
	
	
	
	@Override
	public String toString() {
		return "MemberConnectDTO [c_no=" + c_no + ", c_code=" + c_code + ", u1=" + u1 + ", u2=" + u2 + "]";
	}
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public String getU1() {
		return u1;
	}
	public void setU1(String u1) {
		this.u1 = u1;
	}
	public String getU2() {
		return u2;
	}
	public void setU2(String u2) {
		this.u2 = u2;
	}
	
	
}
