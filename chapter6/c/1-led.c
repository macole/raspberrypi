/* 
 * LEDを点滅する
 * 
 * 使用ライブラリ: wiringPi
 * コンパイル方法: cc -o 1-led 1-led.c -lwiringPi
 */
#include <wiringPi.h>

#define LED_PORT 4		/* GPIO4 */

int main (void) {
	int i;

	//初期化
	if(wiringPiSetupGpio() == -1) return 1;
	pinMode(LED_PORT, OUTPUT);

	for (i=0; i<10; i++) {
		//LED ON
		digitalWrite(LED_PORT, 1);
		delay(500);

		//LED OFF
		digitalWrite(LED_PORT, 0);
		delay(500);
	}

	return 0;
}
