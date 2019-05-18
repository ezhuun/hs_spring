//계정연결이 끊긴 경우 경고창으로 띄운다. 시간이 만료될경우 logout
const createDisconnectWarning = function () {
	const div_layout = document.createElement("div");
	div_layout.setAttribute("class", "header-warning-layout hidden");

	const div_container = document.createElement("div");
	div_container.setAttribute("class", "header-warning-container");

	const span = document.createElement("span");
	span.setAttribute("class", "header-warning-inner");
	span.innerHTML = "상대방과의 연결이 해제되었습니다. 계정연결 만료까지 <span class='countLimit'></span> 남았습니다";

	div_container.appendChild(span);
	div_layout.appendChild(div_container);

	document.body.prepend(div_layout);

	setTimeout(function () {
		div_layout.classList.remove("hidden");
	}, 1000);
}

const connectLimit = document.querySelector("#connectLimit").attributes["data-connectLimit"].value;
if (connectLimit != "") {
	createDisconnectWarning();
	const countLimit = document.querySelector(".countLimit");
	const repeat = setInterval(function () {
		const start = new Date();
		const end = new Date(connectLimit);
		if ((start.getTime() - end.getTime()) >= 0) {
			clearInterval(repeat);
			location.href = contextPath + '/logout';
		}
		const diffTimes = diffTime(end);
		const txt = diffTimes.daysRound + "일 " + diffTimes.hoursRound + "시간 " + diffTimes.minutesRound + "분 " + diffTimes.secondsRound + "초 ";
		countLimit.innerHTML = txt;
	}, 1000);
}

