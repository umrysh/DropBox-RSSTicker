#!/bin/bash

#    Copyright 2012 Dave Umrysh
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Set your DropBox Feed address
FEED="https://www.dropbox.com/yada/yada/yada/events.xml"
ALERT_IMAGE="twitter.jpg"


function ChangeTimeZone
{
	while read DATA
	do
		DATESTRING=`echo "$DATA" | cut -d '-' -f 1`
		DATESTRING2=`echo "$DATESTRING" | sed 's/GMT//g'`
		NEWDATE=`date --date='TZ="GMT" '"$DATESTRING2"`
		echo "$DATA" | sed 's/'"${DATESTRING}"'/'"${NEWDATE}"' /g'
	done
}

function Addcolor
{
	while read DATA
	do
		if [[ "$DATA" =~ "[Dropbox]" ]]
		then
			# Blue
			echo -e "\e[1;34m$DATA\e[0m"
		elif [[ "$DATA" =~ "[Twitter]" ]]
		then
			# Notify Me
			NAME=`echo $DATA | cut -d '-' -f 2- | cut -d ' ' -f3`
			TWEET=`echo $DATA | cut -d '-' -f 2- | cut -d ':' -f 2- | sed 's/^ *//g'`
			if [ "${TWEET:0:1}" != "@" ] ; then
				DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send -i $ALERT_IMAGE -t 5000 --hint=int:transient:1 -- "$NAME" "$TWEET";
			fi
			if [[ ${#DATA} > 140 ]]
			then
				LENGTH=$((${#DATA}-3))
				echo "$DATA" | awk -v var=$LENGTH '{print substr($0,0,var)}'
			else
				echo "$DATA"
			fi
		else
			echo "$DATA"
		fi
	done
}


feedstail -u $FEED -r -i 60 -f "{published} - {summary}" | sed --unbuffered 's/<[^>]\+>//g;s/#38;//g;s/amp;//g;/^$/d' | ChangeTimeZone | Addcolor | grep --color=never -Ev "todo.txt|done.txt"

# If you need feedstail to maintain a larger cache of read items then the default of 100 you can install my fork [https://github.com/umrysh/feedstail] and use the command below instead of the one above. It will increase the cache to 800 items.

# feedstail -u $FEED -c 800 -r -i 60 -f "{published} - {summary}" | sed --unbuffered 's/<[^>]\+>//g;s/#38;//g;s/amp;//g;/^$/d' | ChangeTimeZone | Addcolor | grep --color=never -Ev "todo.txt|done.txt"
