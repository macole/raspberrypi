<?php
require("lib_i2cutil.php");
//
// このプログラムは I2C温度センサー STTS751 専用です
//

define("TEMP_I2CDADDR",0x39);	//センサーのアドレス

//WiringPiのgpioコマンドで/dev/i2c-*の読み書きができるようにする場合はコメントを取る
//exec("/usr/local/bin/gpio load i2c");

//分解能を設定する
$config = i2c_get(TEMP_I2CDADDR, 0x03);		//現在の設定を取得
$config = $config | 0b11 << 2;				//分解能設定のビットを設定
i2c_set(TEMP_I2CDADDR, 0x03, $config);		//設定を書き込む

//温度を取得する
$t1 = i2c_get(TEMP_I2CDADDR, 0x00);		//整数部分の温度を取得
$t2 = i2c_get(TEMP_I2CDADDR, 0x02);		//小数点以下の温度を取得

//温度の計算
$temperature = $t1;
if($t2 & 0b10000000) $temperature += 0.5;
if($t2 & 0b01000000) $temperature += 0.25;
if($t2 & 0b00100000) $temperature += 0.125;
if($t2 & 0b00010000) $temperature += 0.0625;

?>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>I2C温度センサー - Raspberry Piで遊ぼう</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="style.css" media="screen">
<script type="text/javascript">
</script>
</head>
<body>
<div id="wrapper">

<header>
	<div class="header">
		I2C温度センサー<br />
	</div>
</header>

<div id="contents">
	<section>
		<div class="wmain">
			<span style="font-size: large;">
			現在の温度は <strong><?=$temperature?>℃</strong> です。<br />
			</span>
			<br />
			Address 0x00 = 0x<?=sprintf("%02x",$t1)?><br />
			Address 0x02 = 0x<?=sprintf("%02x",$t2)?><br />
		</div>
	</section>
	<section>
		<div class="wmain">
			I2C対応の温度センサー STTS751 の値を読み込みます。<br />
		</div>
	</section>
</div>

<footer>
	<div id="footer">
		Raspberry Piで遊ぼう<br />
	</div>
</footer>

</div>
</body>
</html>
