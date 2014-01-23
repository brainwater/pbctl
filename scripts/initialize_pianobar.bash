#!/bin/bash

srvdir="${1}"

eventcommand="${1}/scripts/eventcmd.bash"

configpath="${HOME}/.config/pianobar/config"

configaddpath="${HOME}/.config/pianobar/pbctl_config"

fifopath="/tmp/pbctl_fifo_control"
if pidof pianobar
then
	echo "Pianobar already exists, doing nothing"
else
	rm "${fifopath}"
	mkfifo "${fifopath}"
	chmod a+rw "${fifopath}"
	
	echo "event_command = ${eventcommand}" > "${configpath}"
	echo "fifo = ${fifopath}" >> "${configpath}"
	cat "${configaddpath}" >> "${configpath}"

	{ sleep 1 && PATH=$PATH:/usr/local/bin pianobar > /tmp/pbctl_pianobar_output 2> /dev/null & } &
fi
