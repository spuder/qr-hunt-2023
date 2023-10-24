# 5

Users had to beat the game. 

At the end of the game it gave them a code word to take to the beauty store



Users went to the beauty store with a flash drive and had to put on polarizing glasses. Those glasses let them see in the monitor a linux desktop where they dragged a bunch of random files to the flash drive. 

The correct file on the flash drive was matt2016.bin

Matthew 20:16 says the last shall be first and the first shall be last.

The solve was to edit the file and take the last character `B` and put it at charater `0` then rename the file to .bmp

Some users brute forced it with a resolution of `1014` on https://rawpixels.net/ with `RBG32`



## Solve

```
(echo -n "B"; cat matt2016.bin) > x.bmp
```

The file gave a qr code

![](matt2016.bmp)


## Winner

> The Butterfly, The BumbleBee & The Wolf!🦋🐝🐺