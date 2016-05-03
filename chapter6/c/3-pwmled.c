/* 
 * PWMでLEDを緩やかに点滅させる
 * 
 * 使用ライブラリ: wiringPi
 * コンパイル方法: cc -o 3-pwmled 3-pwmled.c -lwiringPi
 */
#include <wiringPi.h>

#define LED_PORT 18		/* GPIO18 */

int main (void) {
	int pw, i;

	//初期化
	if(wiringPiSetupGpio() == -1) return 1;
	pinMode(LED_PORT, PWM_OUTPUT);

	for (i=0; i<10; i++) {
		//フェードイン
		for (pw=0; pw<1024; pw++) {
			pwmWrite(LED_PORT, pw);
			delayMicroseconds(300);
		}
		//フェードアウト
		for (pw=1023; pw>=0; pw--) {
			pwmWrite(LED_PORT, pw);
			delayMicroseconds(300);
		}
	}
		
	return 0;
}

