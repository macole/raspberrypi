/* 
 * wiringPiのSoftPWM機能を使って、LEDを緩やかに点滅させる
 * 
 * 使用ライブラリ: wiringPi
 * コンパイル方法: cc -o 4-softpwm 4-softpwm.c -lwiringPi
 */
#include <wiringPi.h>

#define RANGE 100
#define LED_PORT 4		/* GPIO4 */

int main (void) {
	int pw, i;

	//初期化
	if(wiringPiSetupGpio() == -1) return 1;
	softPwmCreate (LED_PORT, 0, RANGE);		//softPwmCreate(ポート,初期値,最大値)

	for (i=0; i<10; i++) {
		//フェードイン
		for (pw=0; pw<=100; pw++) {
			softPwmWrite (LED_PORT, pw);
			delay(3);
		}

		//フェードアウト
		for (pw=100; pw>=0; pw--) {
			softPwmWrite (LED_PORT, pw);
			delay(3);
		}
	}

	return 0;
}

