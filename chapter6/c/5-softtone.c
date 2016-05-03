/* 
 * wiringPiのsoftTone機能を使って、GPIOポートに接続したスピーカーを鳴らす
 * 
 * 使用ライブラリ: wiringPi
 * コンパイル方法: cc -o 5-softtone 5-softtone.c -lwiringPi
 */
#include <wiringPi.h>
#include <softTone.h>

#define BUZ_PORT 27		/* GPIO27 */
#define TONE_HIGH 1000	/* 高い音 1KHz */
#define TONE_LOW  500	/* 低い音 500Hz */

int main (void) {
	int i;

	//初期化
	if(wiringPiSetupGpio() == -1) return 1;
	softToneCreate (BUZ_PORT);

	for (i=0; i<5; i++) {
		softToneWrite (BUZ_PORT, TONE_HIGH);
		delay(500);
		softToneWrite (BUZ_PORT, TONE_LOW);
		delay(500);
	}

	return 0;
}
