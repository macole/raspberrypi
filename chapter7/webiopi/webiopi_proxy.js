//functionの設定
function set_gpio_function(port,dir,callback) {
	var url = "/GPIO/"+port+"/function/"+dir;
	webiopi_api("POST",url,"text","string",callback);
}

//値の取得
function get_gpio_value(port,callback) {
	var url = "/GPIO/"+port+"/value";
	webiopi_api("GET",url,"text","numeric",callback);
}

//値の設定
function set_gpio_value(port,value,callback) {
	var url = "/GPIO/"+port+"/value/"+value;
	webiopi_api("POST",url,"text","numeric",callback);
}

//PWM値の設定(ratio=0〜100)
function set_gpio_pwm(port,ratio,callback) {
	var value = ratio / 100;
	var url = "/GPIO/"+port+"/pulseRatio/"+value;
	webiopi_api("POST",url,"text","float",callback);
}

//PWM値の設定(angle=0〜360)
function set_gpio_servo(port,angle,callback) {
	var url = "/GPIO/"+port+"/pulseAngle/"+angle;
	webiopi_api("POST",url,"text","numeric",callback);
}

//WebIOPi APIとの通信
function webiopi_api(method,url,dataType,convert,callback) {
	$.ajax({
		type: method,
		url: url,
		data: "",
		dataType: dataType,
		success: function(data, dataType) {
			if(callback != undefined) {
				if(convert == "numeric") callback(parseInt(data));
				else if(convert == "float") callback(parseFloat(data));
				else callback(data);
			}
		}
	});
}

