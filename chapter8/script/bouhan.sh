#!/bin/sh
GPIO=24                #--人感センサーのGPIOポート番号
SAVEDIR="$HOME/Photo"  #--画像ファイルの保存先

## GPIOポートの設定
echo $GPIO > /sys/class/gpio/export
sleep 0.5
echo in > /sys/class/gpio/gpio$GPIO/direction

## メインループ
mkdir -p $SAVEDIR
sudo /usr/local/bin/buzzer beep2
echo "監視をスタートします"
while true ; do

  ## センサーが反応するのを待つ
  btn=`cat /sys/class/gpio/gpio$GPIO/value`
  if [ $btn -eq 1 ] ; then
    echo "*** ALERT *** 侵入異常発生"

    ## 撮影
    filename=`date +"%Y%m%d-%H%M%S"`.jpg
    raspistill -o $SAVEDIR/$filename -t 2000 -w 1024 -h 768
    echo "画像を保存しました"

    ## 警報音を鳴らして泥棒を驚かす
    sudo /usr/local/bin/buzzer alert &

    ## 警報発生後は10秒間待機する
    sleep 10
    sudo /usr/local/bin/buzzer beep1
    echo "監視を再開します"
  fi

  ## 0.5秒待機して繰り返す
  sleep 0.5

done
