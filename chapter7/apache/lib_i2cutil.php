<?php

//i2cデバイスの設定（Rev.1基板の場合は1にする）
define("I2CBUS",1);

//i2cget/i2csetコマンドのパス設定
define("I2CGET_COMMAND","/usr/sbin/i2cget");
define("I2CSET_COMMAND","/usr/sbin/i2cset");

//I2Cポートにデータを送信する
function i2c_set16($caddr,$daddr,$data) { return i2c_set($caddr,$daddr,$data,true); }
function i2c_set($caddr,$daddr,$data,$word=false) {
	if($word) {
		$dstr = sprintf("0x%04x ",i2c_endian($data));
		$mode = "w";
	} else {
		$dstr = "";
		if(! is_array($data)) $data = array($data);
		foreach ($data as $num) {
			$dstr .= sprintf("0x%02x ",$num);
		}
		$mode = (count($data) > 1) ? "i" : "b";
	}
	$command = sprintf("%s -y %d 0x%02x 0x%02x %s %s",I2CSET_COMMAND,I2CBUS,$caddr,$daddr,$dstr,$mode);
	exec($command);
	return 0;
}

//I2Cポートからデータを読み込む
function i2c_get16($caddr,$daddr) { return i2c_get($caddr,$daddr,true); }
function i2c_get($caddr,$daddr,$word=false) {
	$data = null;
	$mode = ($word) ? "w" : "b";
	$command = sprintf("%s -y %d 0x%02x 0x%02x %s",I2CGET_COMMAND,I2CBUS,$caddr,$daddr,$mode);
	$fp = popen($command,"r");
	if($fp) {
		$buff = chop(fgets($fp));
		if(eregi("^0x([0-9a-f]+)$",$buff,$tm)) {
			$data = hexdec($tm[1]);
			if($word) $data = i2c_endian($data);
		}
		pclose($fp);
	}
	return $data;
}

//16ビットのエンディアンの変換
function i2c_endian($num) {
	return ($num & 0xff00) >> 8 | ($num & 0x00ff) << 8;
}

//I2Cポートをユーザー権限でアクセス可能にする（sudo実行）
function i2c_load() {
	$devpath = "/dev/i2c-".I2CBUS;
	if(! is_writable($devpath)) {
		exec("sudo chmod o+rw $devpath");
	}
}

?>
