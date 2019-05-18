const allInput = document.querySelectorAll("input[type=email], input[type=text], input[type=password], input[type=number]");
let inputValues = [];
Array.prototype.slice.call(allInput).forEach(function (input, i) {;
	inputValues[i] = input.value;
	input.addEventListener("keyup", function (e) {
		inputValues[i] = input.value;
		const valid = !inputValues.includes("");
		if (valid == true) {
			document.querySelector("#submitBtn").removeAttribute("disabled");
			document.querySelector("#submitBtn").classList.remove("disabled");
		} else {
			document.querySelector("#submitBtn").setAttribute("disabled", "disabled");
			document.querySelector("#submitBtn").classList.add("disabled");
		}
	});
	input.addEventListener("change", function (e) {
		inputValues[i] = input.value;
		const valid = !inputValues.includes("");
		if (valid == true) {
			document.querySelector("#submitBtn").removeAttribute("disabled");
			document.querySelector("#submitBtn").classList.remove("disabled");
		} else {
			document.querySelector("#submitBtn").setAttribute("disabled", "disabled");
			document.querySelector("#submitBtn").classList.add("disabled");
		}
	});
});

const initHelp = function () {
	const els = document.querySelectorAll(".auth-inner-input");
	Array.prototype.slice.call(els).forEach(function (el) {
		el.classList.remove("warning");
		let helps = el.querySelectorAll("span.help");
		if (helps.length > 0) {
			Array.prototype.slice.call(helps).forEach(function (help) {
				help.remove();
			});
		}
	});
};

const createHelp = function (index, str) {
	const els = document.querySelectorAll(".auth-inner-input");
	let span = document.createElement("span");
	span.classList.add("help");
	span.innerText = str;
	els[index].classList.add("warning");
	els[index].getElementsByTagName("input")[0].before(span);
	els[index].getElementsByTagName("input")[0].focus();
};

//==============================================
//Login
//----------------------------------------------
const handleClickForgetPasswd = function () {
	initHelp();
	const email = document.querySelector("#email").value;
	if (email == "") {
		createHelp(0, "- 이메일을 입력하세요");
		return;
	}
	let regex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if (regex.test(email) == false) {
		valid = false;
		createHelp(0, " - 형식이 올바르지 않습니다");
		return;
	}

	const param = {
		"email": email
	};
	const loadingDot = document.querySelector(".loadingDot");
	const submitStr = document.querySelector(".submitStr");

	$.ajax({
		url: contextPath + "/forgetPasswdSendMail",
		method: "post",
		type: "json",
		data: param,
		beforeSend: function () {
			loadingDot.classList.remove("hidden");
			submitStr.classList.add("hidden");
		},
		complete: function () {
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		error: function (err) {
			utils.alert('서버통신오류');
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		success: function (data) {
			if (data == "1") {
				utils.alert('계정 비밀번호 변경을 위해 이메일이 전송되었습니다. 받은 편지함과 스팸함을 확인해보세요.<br>만약, 비밀번호 변경을 원치 않으실 경우 메일은 무시하셔도 됩니다');
			} else {
				createHelp(0, "- 존재하지 않은 이메일입니다");
			}
		}
	});
}

const handleClickLogin = function () {
	initHelp();
	const email = document.querySelector("#email").value;
	const passwd = document.querySelector("#passwd").value;

	let valid = ![email, passwd].includes("");
	if (valid == false) {
		return;
	}
	if (email != "dev") {
		let regex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		if (regex.test(email) == false) {
			valid = false;
			createHelp(0, " - 형식이 올바르지 않습니다");
			return;
		}
	}
	if (passwd.length < 4) {
		valid = false;
		createHelp(1, " - 최소 4자리 이상 입력해주세요");
		return;
	}

	const param = $("#frm").serialize();
	const loadingDot = document.querySelector(".loadingDot");
	const submitStr = document.querySelector(".submitStr");
	$.ajax({
		url: contextPath + "/loginProc",
		method: "post",
		type: "json",
		data: param,
		beforeSend: function () {
			loadingDot.classList.remove("hidden");
			submitStr.classList.add("hidden");
		},
		complete: function () {
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		error: function (err) {
			utils.alert('서버에러');
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		success: function (data) {
			if (data.result == "0") {
				//회원정보없음
				createHelp(0, " - 회원정보가 존재하지 않습니다");
			} else if (data.result == "1") {
				//로그인성공
				location.href = contextPath + "/main";
			} else if (data.result == "2") {
				//비밀번호 불일치
				createHelp(1, " - 비밀번호가 일치하지 않습니다");
			} else if (data.result == "3") {
				//계정연결페이지이동
				let form = document.createElement("form");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "post");
				form.setAttribute("action", contextPath + "/connect");

				let hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "uuid");
				hiddenField.setAttribute("value", data.uuid);
				form.appendChild(hiddenField);

				hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "code");
				hiddenField.setAttribute("value", data.code);
				form.appendChild(hiddenField);

				document.body.appendChild(form);
				form.submit();
			} else if (data.result == "4") {
				//프로필입력페이지 이동
				let form = document.createElement("form");
				form.setAttribute("style", "display:none");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "post");
				form.setAttribute("action", contextPath + "/profile");

				let hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "uuid");
				hiddenField.setAttribute("value", data.uuid);
				form.appendChild(hiddenField);

				document.body.appendChild(form);
				form.submit();
			} else if (data.result == "5") {
				utils.alert('계정연결 유효기간이 만료되었습니다.<br>새 연결을 원하시는 경우 재로그인 하여 계정을 연결해주세요', contextPath + '/');
			}
		}
	});
}

const rememberMe = function (radio) {
	if (radio.checked === true) {
		utils.alert('우리는 최소 3일간 당신을 기억하겠습니다');
	}
}

//==============================================
//register
//----------------------------------------------
const handleClickRegister = function () {
	initHelp();
	const email = document.querySelector("#email").value;
	const passwd = document.querySelector("#passwd").value;
	const passwdCheck = document.querySelector("#passwdCheck").value;

	let valid = ![email, passwd, passwdCheck].includes("");
	if (valid == false) {
		return;
	}
	let regex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if (regex.test(email) == false) {
		valid = false;
		createHelp(0, " - 형식이 올바르지 않습니다");
		return;
	}
	if (passwd.length < 4) {
		valid = false;
		createHelp(1, " - 최소 4자리 이상 입력해주세요");
		return;
	}

	if (passwd !== passwdCheck) {
		valid = false;
		createHelp(1, " - 비밀번호가 일치하지 않습니다");
		return;
	}

	const param = $("#frm").serialize();
	const loadingDot = document.querySelector(".loadingDot");
	const submitStr = document.querySelector(".submitStr");
	$.ajax({
		url: contextPath + "/register",
		method: "post",
		type: "json",
		data: param,
		beforeSend: function () {
			loadingDot.classList.remove("hidden");
			submitStr.classList.add("hidden");
		},
		complete: function () {
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		error: function (err) {
			utils.alert('서버에러');
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		success: function (data) {
			if (data.result == "0") {
				createHelp(0, " - 중복된 이메일입니다");
			} else if (data.result == "2") {
				utils.alert('다시 시도 해주세요');
			} else if (data.result == "1") {
				let form = document.createElement("form");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "post");
				form.setAttribute("action", contextPath + "/connect");

				let hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "uuid");
				hiddenField.setAttribute("value", data.uuid);
				form.appendChild(hiddenField);

				hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "code");
				hiddenField.setAttribute("value", data.code);
				form.appendChild(hiddenField);

				document.body.appendChild(form);
				form.submit();
			}
		}
	});
}

//==============================================
//connect
//----------------------------------------------
//setinteval을 이용하여 주기적으로 db점검필요.. 상대방이 연결했다면 다음페이지로 이동시키기 위함..
//일단 2초에 한번씩 검사하는걸로..
const uuid = document.querySelector("#uuid").value.trim();
setInterval(function () {
	$.ajax({
		url: contextPath + "/getCode",
		method: "post",
		type: "json",
		data: {
			uuid: uuid
		},
		success: function (data) {
			if (data.trim().length > 0) {
				let form = document.createElement("form");
				form.setAttribute("style", "display:none");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "post");
				form.setAttribute("action", contextPath + "/profile");

				let hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "uuid");
				hiddenField.setAttribute("value", uuid);
				form.appendChild(hiddenField);

				document.body.appendChild(form);
				form.submit();
			}
		}
	});
}, 2000);

const handleClickConnect = function () {
	initHelp();
	const uuid = document.querySelector("#uuid").value.trim();
	const code = document.querySelector("#code").value.trim();

	if (code.length !== 8) {
		createHelp(1, " - 유효한 코드가 아닙니다");
		return;
	}

	const param = {
		uuid: uuid,
		code: code
	};
	const loadingDot = document.querySelector(".loadingDot");
	const submitStr = document.querySelector(".submitStr");
	$.ajax({
		url: contextPath + "/registerCode",
		method: "post",
		type: "json",
		data: param,
		beforeSend: function () {
			loadingDot.classList.remove("hidden");
			submitStr.classList.add("hidden");
		},
		complete: function () {
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		error: function (err) {
			utils.alert('서버에러');
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		success: function (data) {
			if (data.result == "0") {
				//code is null
				createHelp(1, " - 유효한 코드가 아닙니다");
			} else if (data.result == "2") {
				//자신의 코드로는 등록할 수 없습니다
				createHelp(1, " - 유효한 코드가 아닙니다");
			} else if (data.result == "3") {
				//초대코드 만료(이미 연결된 사용자인지, 등록안료된 초대코드인지)
				createHelp(1, " - 유효한 코드가 아닙니다");
			} else if (data.result == "4") {
				//db error
				utils.alert('DB error');
			} else if (data.result == "5") {
				//관리자 전용코드
				createHelp(1, " - 유효한 코드가 아닙니다");
			}
			if (data.result == "1") {
				//연결성공
				let form = document.createElement("form");
				form.setAttribute("style", "display:none");
				form.setAttribute("charset", "UTF-8");
				form.setAttribute("method", "post");
				form.setAttribute("action", contextPath + "/profile");

				let hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "uuid");
				hiddenField.setAttribute("value", data.uuid);
				form.appendChild(hiddenField);

				document.body.appendChild(form);
				form.submit();
			}
		}
	});

};

const sendEmail = function (mycode) {
	const email = document.querySelector("#sendEmail").value.trim();
	if (email == "") {
		utils.alert('이메일 주소를 입력해주세요');
		return;
	}

	const param = {
		email: email,
		code: mycode
	};
	const url = contextPath + "/sendEmail";

	const modal = document.querySelector(".modal-form-container");
	const loadingDot = modal.querySelector(".loadingDot");
	const btnStr = modal.querySelector(".btnStr");

	$.ajax({
		url: url,
		method: "post",
		type: "json",
		data: param,
		beforeSend: function () {
			loadingDot.classList.remove("hidden");
			btnStr.classList.add("hidden");
		},
		complete: function () {
			loadingDot.classList.add("hidden");
			btnStr.classList.remove("hidden");
		},
		error: function (err) {
			utils.alert('서버에러');
			loadingDot.classList.add("hidden");
			btnStr.classList.remove("hidden");
		},
		success: function (data) {
			if (data == "1") {
				utils.alert('메일을 전송했습니다');
				utils.popupFormClose();
			} else {
				utils.alert('메일전송에 실패했습니다. 다시 시도해주세요');
			}
		}
	});
};

const handleClickOpenSendBox = function () {
	const mycode = document.querySelector("#mycode").value;
	utils.popupForm("초대코드 공유",
		"<span>상대방 이메일 주소를 입력해주세요. 초대코드를 전송합니다. </span> <input type='email' id='sendEmail'/> ",
		"<button onclick='sendEmail(\"" + mycode + "\");'><div class='loadingDot hidden'><div></div><div></div><div></div></div><span class='btnStr'>전송</span></button>"
	);
};

//==============================================
//profile
//----------------------------------------------
const handleClickUpdateProfile = function () {
	initHelp();
	const name = document.querySelector("#name").value.trim();
	if (name.length < 2) {
		createHelp(1, " - 최소 2자리 이상 입력해주세요");
		return;
	}
	if (new RegExp('[`~!@#$%^&*|\\\'\";:\/?]', 'gi').test(name) == true) {
		createHelp(1, " - 특수문자는 포함할 수 없습니다");
		return;
	}

	const param = $("#frm").serialize();
	const loadingDot = document.querySelector(".loadingDot");
	const submitStr = document.querySelector(".submitStr");
	$.ajax({
		url: contextPath + "/updateProfile",
		method: "post",
		type: "json",
		data: param,
		beforeSend: function () {
			loadingDot.classList.remove("hidden");
			submitStr.classList.add("hidden");
		},
		complete: function () {
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		error: function (err) {
			utils.alert('서버에러');
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		success: function (data) {
			if (data != "0") {
				location.href = contextPath + "/main";
			} else {
				utils.alert('로그인에 실패했습니다');
			}
		}
	});
}

const handleChangePhoto = function (e) {
	let file = e.target.files[0];
	let formData = new FormData();
	formData.append("file", file);
	formData.append("uuid", document.querySelector("#uuid").value.trim());

	$.ajax({
		url: contextPath + "/upload/uploadAjax",
		method: "post",
		type: "json",
		data: formData,
		processData: false,
		contentType: false,
		success: function (data) {
			if (data != "0") {
				document.querySelector("#profileImage").src = contextPath + "/upload/profile/" + data;
			} else {
				utils.alert('이미지 등록 실패');
			}
		}
	});
}

//==============================================
//reRegisterPasswd
//----------------------------------------------
const handleChangePasswd = function () {
	initHelp();

	const passwd = document.querySelector("#passwd").value;
	const passwdCheck = document.querySelector("#passwdCheck").value;

	let valid = ![passwd, passwdCheck].includes("");
	if (valid == false) {
		return;
	}
	if (passwd.length < 4) {
		valid = false;
		createHelp(0, " - 최소 4자리 이상 입력해주세요");
		return;
	}

	if (passwd !== passwdCheck) {
		valid = false;
		createHelp(0, " - 비밀번호가 일치하지 않습니다");
		return;
	}

	const param = $("#frm").serialize();
	const loadingDot = document.querySelector(".loadingDot");
	const submitStr = document.querySelector(".submitStr");

	$.ajax({
		url: contextPath + "/reRegisterPasswd",
		method: "post",
		type: "json",
		data: param,
		beforeSend: function () {
			loadingDot.classList.remove("hidden");
			submitStr.classList.add("hidden");
		},
		complete: function () {
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		error: function (err) {
			utils.alert('서버통신오류');
			loadingDot.classList.add("hidden");
			submitStr.classList.remove("hidden");
		},
		success: function (data) {
			if (data == "1") {
				utils.alert('비밀번호가 변경되었습니다', contextPath + '/');
			} else {
				utils.alert('비밀번호 변경을 실패했습니다');
			}
		}
	});
}