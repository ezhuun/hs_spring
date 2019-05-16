package com.spring.hs.dto.member;

public class MemberDTO {

	private int no;
	private String uuid;
	private String email;
	private String passwd;
	private String name;
	private String birth;
	private String begin_date;
	private String regdt;
	private String last_login;
	private String auth_key;
	private String auth_status;
	private String session_key;
	private String session_limit;
	private String profile;
	private String temp_code;
	private String c_code;
	private String gender;
	private MemberDTO lover;
	private MemberConnectDTO connect;
	

	@Override
	public String toString() {
		return "MemberDTO [no=" + no + ", uuid=" + uuid + ", email=" + email + ", passwd=" + passwd + ", name=" + name
				+ ", birth=" + birth + ", begin_date=" + begin_date + ", regdt=" + regdt + ", last_login=" + last_login
				+ ", auth_key=" + auth_key + ", auth_status=" + auth_status + ", session_key=" + session_key
				+ ", session_limit=" + session_limit + ", profile=" + profile + ", temp_code=" + temp_code + ", c_code="
				+ c_code + ", gender=" + gender + ", lover=" + lover + ", connect=" + connect + "]";
	}
	public MemberConnectDTO getConnect() {
		return connect;
	}
	public void setConnect(MemberConnectDTO connect) {
		this.connect = connect;
	}
	public MemberDTO getLover() {
		return lover;
	}
	public void setLover(MemberDTO lover) {
		this.lover = lover;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getBegin_date() {
		return begin_date;
	}
	public void setBegin_date(String begin_date) {
		this.begin_date = begin_date;
	}
	public String getRegdt() {
		return regdt;
	}
	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}
	public String getLast_login() {
		return last_login;
	}
	public void setLast_login(String last_login) {
		this.last_login = last_login;
	}
	public String getAuth_key() {
		return auth_key;
	}
	public void setAuth_key(String auth_key) {
		this.auth_key = auth_key;
	}
	public String getAuth_status() {
		return auth_status;
	}
	public void setAuth_status(String auth_status) {
		this.auth_status = auth_status;
	}
	public String getSession_key() {
		return session_key;
	}
	public void setSession_key(String session_key) {
		this.session_key = session_key;
	}
	public String getSession_limit() {
		return session_limit;
	}
	public void setSession_limit(String session_limit) {
		this.session_limit = session_limit;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getTemp_code() {
		return temp_code;
	}
	public void setTemp_code(String temp_code) {
		this.temp_code = temp_code;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	
	

}
