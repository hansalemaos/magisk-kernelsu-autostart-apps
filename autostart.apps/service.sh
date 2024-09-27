#!/system/bin/sh
scriptfile="/sdcard/hansgisk/runapps.sh"
MODDIR=${0%/*}
while [ "$(getprop sys.boot_completed)" != 1 ]; do
    sleep 1
done
while [ ! -d "/sdcard" ] || [ ! -e "/system/bin/am" ] || [ ! -e "/system/bin/cmd" ]; do
    sleep 3
done
PATH=$PATH:/system/bin

sleep 3
strip_string() {
    printf "%s\n" "$*" | awk '{$1=$1};1'
}
startswith() { case $2 in "$1"*) true;; *) false;; esac; }
if [ ! -f "$scriptfile" ]; then
    exit 1
fi
allmypackages="$(cat "$scriptfile")"
for propfilenumber in $(seq 1 $(printf "%s\n" "$allmypackages" | wc -l)); do
    original_data="$(printf "%s\n" "$allmypackages" | sed -n "${propfilenumber}p")"
    if [ -z "$original_data" ]; then
        continue
    elif startswith "PACKAGESTART"  "$(strip_string "$original_data")"; then
        packname="$(printf "%s" "$original_data" | awk 'BEGIN{FS="PACKAGESTART[[:space:]]+"}{print $2}' )"
        /system/bin/am  start "$(/system/bin/cmd package resolve-activity --brief "$packname" | tail -n 1)"
    else
        eval "$original_data"
    fi
done

