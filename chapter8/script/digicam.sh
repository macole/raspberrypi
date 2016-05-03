#!/bin/sh
GPIO=25            #--シャッターボタンのGPIOポート番号
WIDTH=1200         #--保存サイズ(横)
HEIGHT=800         #--保存サイズ(縦)
WAIT=1000          #--シャッターを押してから撮影するまでの時間(ミリ秒)
CAMOPT="-q 90"     #--その他raspistillコマンドのオプション
PREVIEW=3          #--撮影後のプレビュー時間(秒)
SAVEDIR="$HOME/Photo"  #--画像ファイルの保存先

## GPIOポートの設定
echo $GPIO > /sys/class/gpio/export
sleep 0.5
echo in > /sys/class/gpio/gpio$GPIO/direction

## その他準備
tmpimg="/tmp/image.jpg"
cntpath="$HOME/.digicam_cnt"
mkdir -p $SAVEDIR

## メインループ
while true ; do

  ## ボタンが押されるのを待つ
  btn=`cat /sys/class/gpio/gpio$GPIO/value`
  if [ $btn -eq 1 ] ; then

    ## 撮影
    raspistill -o $tmpimg -t $WAIT -w $WIDTH -h $HEIGHT $CAMOPT

    ## fbiがインストールされていたらプレビュー
    which fbi > /dev/null
    if [ $? = 0 ] ; then
      fbi $tmpimg -a -t $PREVIEW -1 >/dev/null 2>&1
    fi

    ## カウントアップ
    ! [ -f $cntpath ] && echo -n 0 > $cntpath
    cnt=`cat $cntpath`
    newcnt=`expr $cnt + 1`
    echo -n $newcnt > $cntpath

    ##画像ファイルの保存
    filename=`perl -e '{printf "RASP%04d.JPG",$ARGV[0]}' $newcnt`
    cp -f $tmpimg $SAVEDIR/$filename
    echo SAVED $SAVEDIR/$filename
  fi

  ## 0.1秒待機して繰り返す
  sleep 0.1

done
