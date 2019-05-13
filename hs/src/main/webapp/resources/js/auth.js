const allInput = document.querySelectorAll("input[type=email], input[type=text], input[type=password], input[type=number]");
let inputValues = [];
allInput.forEach(function (input, i) {;
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
	els.forEach(function (el) {
		el.classList.remove("warning");
		let helps = el.querySelectorAll("span.help");
		if (helps.length > 0) {
			helps.forEach(function (help) {
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