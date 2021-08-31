#!/bin/bash

# to set up monitoring whenever this machine is on, use systemd:
# create a service file, see /home/theod/.config/systemd/user/monitor_djerba.service for an example
# enable it: systemctl --user enable monitor_djerba.service 
# start it: systemctl --user start monitor_djerba.service

HOST="${1}"
LOG="/var/log/monitor_device/${1}.log"
STATE="up"
DATE_CMD="date -Iseconds"

update_ip () {
	if echo "${HOST}" | grep -q '[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}' &>/dev/null; then
		IP="${HOST}"
	else
		NEW="$(getent hosts "${HOST}" | cut -d' ' -f1)"
		if [ ! -z "${NEW}" ]; then
			IP="${NEW}"
		fi
	fi
}

update_ip

echo "$(${DATE_CMD}): starting monitoring for host ${HOST} at ${IP}" >> "${LOG}"

while true; do
	update_ip
	if ping -c1 -W1 "${HOST}" &>/dev/null; then
		if [ "${STATE}" == "down" ]; then
			echo "$(${DATE_CMD}): ${HOST} came back up at ${IP}" >> "${LOG}"
		fi
		STATE="up"
	else
		if [ "${STATE}" == "up" ]; then
			echo "$(${DATE_CMD}): ${HOST} went down at ${IP}" >> "${LOG}"
		fi
		STATE="down"
	fi
	sleep 1
done

