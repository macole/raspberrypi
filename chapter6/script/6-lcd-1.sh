#!/bin/sh

# LCDの初期化
i2cset -y 1 0x3e 0 0x38 0x39 0x14 0x78 0x5f 0x6a i
sleep 0.3
i2cset -y 1 0x3e 0 0x0c 0x01 i
sleep 0.3
i2cset -y 1 0x3e 0 0x06 i
sleep 0.3

# 文字を出力（1行目）
i2cset -y 1 0x3e 0 0x80 b
i2cset -y 1 0x3e 0x40 0x48 0x65 0x6c 0x6c 0x6f 0x2c i

# 文字を出力（2行目）
i2cset -y 1 0x3e 0 0xc0 b
i2cset -y 1 0x3e 0x40 0x57 0x6f 0x72 0x6c 0x64 0x21 i
