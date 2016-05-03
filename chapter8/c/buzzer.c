/* 
 * wiringPiのsoftTone()で様々なサウンドを出力する
 * 
 * 使用ライブラリ: wiringPi
 * コンパイル方法: cc -o buzzer buzzer.c -lwiringPi
 * インストール方法: sudo cp buzzer /usr/local/bin/
 * 使用方法: sudo /usr/local/bin/buzzer オプション（alert,beep1,beep2）
 */
#include <wiringPi.h>
#include <softTone.h>

#define BUZ_PORT 27    /* GPIO27 */

int main (int argc, char *argv[]) {
	int freq, i;

	//初期化
	if(wiringPiSetupGpio() == -1) return 1;
	softToneCreate (BUZ_PORT);

	//警報モード
	if(strcmp(argv[1], "alert") == 0) {
		for (i=0; i<10; i++) {
			for (freq=1000; freq>=0; freq-=100) {
				softToneWrite (BUZ_PORT, freq);
				delay(30);
			}
		}
	}

	//短いビープ音
	if(strcmp(argv[1], "beep1") == 0) {
		softToneWrite (BUZ_PORT, 1000);
		delay(50);
	}

	//長いビープ音
	if(strcmp(argv[1], "beep2") == 0) {
		softToneWrite (BUZ_PORT, 1000);
		delay(500);
	}

	return 0;
}
