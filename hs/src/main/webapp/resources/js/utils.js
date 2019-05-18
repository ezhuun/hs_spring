const contextPath = document.querySelector("#contextPathHolder").attributes["data-contextpath"].value;

//===================================================================================
//IE 호환문제 prepend, remove, before
//-------------------------------------[use]-----------------------------------------
(function (arr) {
	  arr.forEach(function (item) {
	    if (item.hasOwnProperty('prepend')) {
	      return;
	    }
	    Object.defineProperty(item, 'prepend', {
	      configurable: true,
	      enumerable: true,
	      writable: true,
	      value: function prepend() {
	        var argArr = Array.prototype.slice.call(arguments),
	          docFrag = document.createDocumentFragment();
	        
	        argArr.forEach(function (argItem) {
	          var isNode = argItem instanceof Node;
	          docFrag.appendChild(isNode ? argItem : document.createTextNode(String(argItem)));
	        });
	        
	        this.insertBefore(docFrag, this.firstChild);
	      }
	    });
	  });
	})([Element.prototype, Document.prototype, DocumentFragment.prototype]);

(function (arr) {
	  arr.forEach(function (item) {
	    if (item.hasOwnProperty('remove')) {
	      return;
	    }
	    Object.defineProperty(item, 'remove', {
	      configurable: true,
	      enumerable: true,
	      writable: true,
	      value: function remove() {
	        this.parentNode.removeChild(this);
	      }
	    });
	  });
	})([Element.prototype, CharacterData.prototype, DocumentType.prototype]);

(function (arr) {
	  arr.forEach(function (item) {
	    if (item.hasOwnProperty('before')) {
	      return;
	    }
	    Object.defineProperty(item, 'before', {
	      configurable: true,
	      enumerable: true,
	      writable: true,
	      value: function before() {
	        var argArr = Array.prototype.slice.call(arguments),
	          docFrag = document.createDocumentFragment();
	        
	        argArr.forEach(function (argItem) {
	          var isNode = argItem instanceof Node;
	          docFrag.appendChild(isNode ? argItem : document.createTextNode(String(argItem)));
	        });
	        
	        this.parentNode.insertBefore(docFrag, this);
	      }
	    });
	  });
	})([Element.prototype, CharacterData.prototype, DocumentType.prototype]);
	
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
	},
	popupFormInitHelp: function(){
		const els = document.querySelectorAll(".modal-form-inner input");
		Array.prototype.slice.call(els).forEach(function (el) {
			el.parentNode.classList.remove("warning");
			let helps = el.parentNode.querySelectorAll("span.help");
			if (helps.length > 0) {
				Array.prototype.slice.call(helps).forEach(function (help) {
					help.remove();
				});
			}
		});
	},
	popupFormCreateHelp: function(index, str){
		const els = document.querySelectorAll(".modal-form-inner input");
		let span = document.createElement("span");
		span.classList.add("help");
		span.innerText = str;
		Array.prototype.slice.call(els).forEach(function (el, i) {
			
			if(i == index){
				el.parentNode.classList.add("warning");
				el.parentNode.getElementsByTagName("input")[0].before(span);
				el.parentNode.getElementsByTagName("input")[0].focus();
			}
		});
	}


};

//===================================================================================
// isNumber(element)
//-----------------------------------------------------------------------------------
const isNumber = function(el){
	el.value = el.value.replace(new RegExp('[^0-9]', 'gi'), "");
}


//===================================================================================
//diffTime(endTime)
//-----------------------------------------------------------------------------------
const diffTime = function getTime(end) { 
	const now = new Date(); 
	const dday = new Date(end); 
	
	const days = (dday - now) / 1000 / 60 / 60 / 24; 
	const daysRound = Math.floor(days); 
	const hours = (dday - now) / 1000 / 60 / 60 - (24 * daysRound); 
	const hoursRound = Math.floor(hours); 
	const minutes = (dday - now) / 1000 /60 - (24 * 60 * daysRound) - (60 * hoursRound); 
	const minutesRound = Math.floor(minutes); 
	const seconds = (dday - now) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) - (60 * minutesRound); 
	const secondsRound = Math.round(seconds); 
	
	const diffDays = {};
	diffDays['daysRound'] =  daysRound;
	diffDays['hoursRound'] =  hoursRound;
	diffDays['minutesRound'] =  minutesRound;
	diffDays['secondsRound'] =  secondsRound;
	
	return diffDays;
} 