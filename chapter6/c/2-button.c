/* 
 * ボタンの状態を取得する
 * 
 * 使用ライブラリ: wiringPi
 * コンパイル方法: cc -o 2-button 2-button.c -lwiringPi
 */
#include <stdio.h>
#include <wiringPi.h>

#define BTN_PORT 25		/* GPIO25 */

int main (void) {
	int data, i;

	//初期化
	if(wiringPiSetupGpio() == -1) return 1;
	pinMode(BTN_PORT, INPUT);

	//読み込み（1秒ごとに10回繰り返す）
	for (i=0; i<10; i++) {
		data = digitalRead(BTN_PORT);
		printf("GPIO%d = %d\n",BTN_PORT,data);
		sleep(1);
	}

	return 0;
}
