const contextPath = document.querySelector("#contextPathHolder").attributes["data-contextpath"].value;

//===================================================================================
//utils
//-------------------------------------[use]-----------------------------------------
//utils.alert(str, goUrl, addedBtn);
//utils.alertClose();
//utils.popupForm(title, inner, btn);
//utils.popupFormClose();
//-----------------------------------------------------------------------------------
const utils = {
	alert: function (str, goUrl, addedBtn) {
		let div_layout = document.createElement("div");
		div_layout.setAttribute("class", "modal-layout");

		let div_alert = document.createElement("div");
		div_alert.setAttribute("class", "modal-alert");
		div_alert.setAttribute("tabindex", "0");

		/**inner**/
		let div_alert_container = document.createElement("div");
		div_alert_container.setAttribute("class", "modal-alert-container");
		div_alert_container.setAttribute("tabindex", "0");

		let h3 = document.createElement("h3");
		h3.innerText = "알려드립니다";

		let modal_inner_text = document.createElement("span");
		modal_inner_text.setAttribute("class", "modal-inner-text");
		modal_inner_text.innerHTML = str;

		/**button**/
		let modal_inner_button = document.createElement("div");
		modal_inner_button.setAttribute("class", "modal-inner-button");

		let modal_added_button = document.createElement("div");
		modal_added_button.setAttribute("class", "modal-added-button");
		if (addedBtn !== undefined && addedBtn != "") {
			modal_added_button.innerHTML = addedBtn;
		} else {
			modal_added_button.innerHTML = "";
		}

		let button = document.createElement("button");
		button.innerText = "확인";
		if (goUrl !== undefined && goUrl != "") {
			button.onclick = function () {
				utils.alertClose(goUrl);
			}
		} else {
			button.onclick = function () {
				utils.alertClose();
			}
		}
		div_alert.addEventListener("click", function (e) {
			e.preventDefault();
			div_alert_container.focus();
		});
		div_alert_container.addEventListener("keyup", function (e) {
			if (["Enter","Escape","Space"].includes(e.code)) {
				utils.alertClose();
				if(document.querySelector(".modal-form-container")){
					document.querySelector(".modal-form-container").focus();
				}
			}
		});

		modal_inner_button.appendChild(modal_added_button);
		modal_inner_button.appendChild(button);
		div_alert_container.appendChild(h3);
		div_alert_container.appendChild(modal_inner_text);
		div_alert_container.appendChild(modal_inner_button);
		div_alert.appendChild(div_alert_container);
		div_layout.appendChild(div_alert);
		document.body.prepend(div_layout);
		div_alert_container.focus();
	},
	alertClose: function (goUrl) {
		const modal_alert = document.querySelector(".modal-layout");
		if (goUrl !== undefined && goUrl != "") {
			location.href = goUrl;
		}
		if(document.querySelector(".modal-form-container")){
			document.querySelector(".modal-form-container").focus();
		}
		modal_alert.remove();
	},
	popupForm: function (title, inner, btn) {
		let div_layout = document.createElement("div");
		div_layout.setAttribute("class", "modal-form-layout");

		let div_form = document.createElement("div");
		div_form.setAttribute("class", "modal-form");
		div_form.setAttribute("tabindex", "0");

		let div_container = document.createElement("div");
		div_container.setAttribute("class", "modal-form-container");
		div_container.setAttribute("tabindex", "0");

		let div_title = document.createElement("div");
		div_title.setAttribute("class", "modal-form-title");
		if (title !== undefined && title != "") {
			div_title.innerHTML = title;
		}

		let div_inner = document.createElement("div");
		div_inner.setAttribute("class", "modal-form-inner");
		if (inner !== undefined && inner != "") {
			div_inner.innerHTML = inner;
		}

		let div_button = document.createElement("div");
		div_button.setAttribute("class", "modal-form-button");
		if (btn !== undefined && btn != "") {
			div_button.innerHTML = btn;
		}
		div_container.addEventListener("mouseup", function (e) {
			e.stopPropagation();
		});
		div_form.addEventListener("mouseup", function (e) {
			if(e.button == 0){
			 utils.popupFormClose();
			}
		});
		div_container.addEventListener("keyup", function (e) {
			if (e.code == "Escape") {
				utils.popupFormClose();
			}
		});

		div_container.appendChild(div_title);
		div_container.appendChild(div_inner);
		div_container.appendChild(div_button);
		div_form.appendChild(div_container);
		div_layout.appendChild(div_form);
		document.body.prepend(div_layout);
		div_container.focus();
	},
	popupFormClose: function () {
		const modal_form = document.querySelector(".modal-form-layout");
		modal_form.remove();
	}
};

//===================================================================================
// isNumber(element)
//-----------------------------------------------------------------------------------
const isNumber = function(el){
	el.value = el.value.replace(new RegExp('[^0-9]', 'gi'), "");
}