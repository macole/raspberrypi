#!/usr/bin/php
<?php
//
// このプログラムは I2C液晶LCD SB1602BW 専用です
//
require("lib_i2cutil.php");

define("LCD_I2CDADDR",0x3e);	//LCDのアドレス
define("COLUMN",16);			//LCDの桁数
define("CONTRAST",8);			//LCDのコントラスト（0〜15）

//LCDの初期化
$fcnt = 0x70 | (CONTRAST & 0x0f);
i2c_set(LCD_I2CDADDR, 0, array(0x38,0x39,0x14,$fcnt,0x5f,0x6a) );
usleep(300000);
i2c_set(LCD_I2CDADDR, 0, array(0x0c,0x01) );
usleep(300000);
i2c_set(LCD_I2CDADDR, 0, 0x06 );
usleep(300000);

//引数の文字を半角英数字にする
$text = $argv[1];
$text = mb_convert_kana($text,"askh","UTF-8");
$text = mb_convert_encoding($text,"SJIS","UTF-8");
$text = str_pad($text,COLUMN*2," ");

//文字を数値に変換する
$out = array();
for ($i=0; $i<COLUMN*2; $i++) {
	$out[] = ord( substr($text,$i,1) );
}

//文字を送信する（１列目：1〜16文字目を出力）
i2c_set(LCD_I2CDADDR, 0, 0x80 );	//位置
i2c_set(LCD_I2CDADDR, 0x40, array_slice($out,0,COLUMN) );	//出力

//文字を送信する（２列目：16〜32文字目を出力）
i2c_set(LCD_I2CDADDR, 0, 0xc0 );	//位置
i2c_set(LCD_I2CDADDR, 0x40, array_slice($out,COLUMN,COLUMN) );	//出力

exit(0);
?>
