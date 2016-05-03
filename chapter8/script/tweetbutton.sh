#!/bin/sh
#
# GPIO 18,23,24,25に接続したボタンが押されたら、各ボタンに対応する
# メッセージをツイートする。送信後に.wavファイルを再生する。
#

## 各ボタンに割り当てるGPIOポートの設定
port1=18
port2=23
port3=24
port4=25

## 各ボタンの投稿メッセージの設定
message1="本日開店です"
message2="パンが焼き上がりました！"
message3="ただ今売り切れです"
message4="本日は閉店しました"

## サウンドの設定例
# ステレオ端子に出力する場合 → amixer cset numid=3 1
# HDMIに出力する場合 → amixer cset numid=3 2
# 音量を調整する → alsamixer

## モードの設定
gpio -g mode $port1 in
gpio -g mode $port2 in
gpio -g mode $port3 in
gpio -g mode $port4 in

## メインのループ
echo "ツイートボタン1〜4を押してください"
while true ; do

  ## ボタンの状態を取得
  btn1=`gpio -g read $port1`
  btn2=`gpio -g read $port2`
  btn3=`gpio -g read $port3`
  btn4=`gpio -g read $port4`

  ## ボタン1が押された場合
  if [ $btn1 -eq 1 ] ; then
    tweet="$message1 `date +%H:%M`"
    echo "ツイートしています..."
    ttytter -ssl -status="$tweet" >/dev/null
    echo "ツイートしました:" $tweet
    aplay -q /usr/share/scratch/Media/Sounds/Electronic/Whoop.wav
    sleep 5
  fi

  ## ボタン2が押された場合
  if [ $btn2 -eq 1 ] ; then
    tweet="$message2 `date +%H:%M`"
    echo "ツイートしています..."
    ttytter -ssl -status="$tweet" >/dev/null
    echo "ツイートしました:" $tweet
    aplay -q /usr/share/scratch/Media/Sounds/Electronic/Whoop.wav
    sleep 5
  fi

  ## ボタン3が押された場合
  if [ $btn3 -eq 1 ] ; then
    tweet="$message3 `date +%H:%M`"
    echo "ツイートしています..."
    ttytter -ssl -status="$tweet" >/dev/null
    echo "ツイートしました:" $tweet
    aplay -q /usr/share/scratch/Media/Sounds/Electronic/Whoop.wav
    sleep 5
  fi

  ## ボタン4が押された場合
  if [ $btn4 -eq 1 ] ; then
    tweet="$message4 `date +%H:%M`"
    echo "ツイートしています..."
    ttytter -ssl -status="$tweet" >/dev/null
    echo "ツイートしました:" $tweet
    aplay -q /usr/share/scratch/Media/Sounds/Electronic/Whoop.wav
    sleep 5
  fi

  ## 0.1秒待機して繰り返す
  sleep 0.1
done

