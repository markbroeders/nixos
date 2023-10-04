#!/bin/sh

get_vol() {
	echo $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -c 3)
}

print_vol() {
	if [ $(get_vol) = "D]" ]; then
		echo "muted"
	else
		echo "$(get_vol)%";
	fi
}

print_bat() {
	status=$(cat /sys/class/power_supply/BAT0/status)
	charge=$(cat /sys/class/power_supply/BAT0/capacity)
	
	if [ $status = "Discharging" ]; then
		echo "${charge}";
	else
		echo "${charge}";
	fi
}

print_date() {
	date=$(date +"%R %F")
	echo "$date"
}

# Statusbar loop
while true; do
	xsetroot -name " $(print_vol)  $(print_bat)  $(print_date)";
	sleep 1m;    # Update time every minute
done &

# Bluetooth applet
blueman-applet &

# Networkmanager applet (disabled for now)
# nm-applet &

# Set wallpaper
feh --bg-scale ~/Pictures/background.jpg &

# Enable libinput-gestures for devices with touchpad only
[ "$HOSTNAME" == "wheeler" ] && libinput-gestures &
