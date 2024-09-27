# magisk-kernelsu-autostart-apps
Script to autostart apps

```
Create a file called runapps.sh


PACKAGESTART com.termux
sleep 3
PACKAGESTART com.spotify.music
echo "oi"



adb -s 127.0.0.1:5556 shell mkdir -p /sdcard/hansgisk
adb -s 127.0.0.1:5556 push C:\Users\hansc\Desktop\blissin\runapps.sh  /sdcard/hansgisk
adb -s 127.0.0.1:5556 push "C:\Users\hansc\Desktop\blissin2\neu\magiskmodules\autostart.apps.zip" /sdcard

```
