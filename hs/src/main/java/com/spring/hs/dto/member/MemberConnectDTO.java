package com.spring.hs.dto.member;

public class MemberConnectDTO {
	private int c_no;
	private String c_code;
	private String u1;
	private String u2;
	private String d_status;
	private String d_limit;
	private String d_uuid;
	
	@Override
	public String toString() {
		return "MemberConnectDTO [c_no=" + c_no + ", c_code=" + c_code + ", u1=" + u1 + ", u2=" + u2 + ", d_status="
				+ d_status + ", d_limit=" + d_limit + ", d_uuid=" + d_uuid + "]";
	}
	public String getD_status() {
		return d_status;
	}
	public void setD_status(String d_status) {
		this.d_status = d_status;
	}
	public String getD_limit() {
		return d_limit;
	}
	public void setD_limit(String d_limit) {
		this.d_limit = d_limit;
	}
	public String getD_uuid() {
		return d_uuid;
	}
	public void setD_uuid(String d_uuid) {
		this.d_uuid = d_uuid;
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
