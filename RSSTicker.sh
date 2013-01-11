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


feedstail -u $FEED -r -i 60 -f "{published} - {summary}" | sed --unbuffered 's/<[^>]\+>//g;s/#38;//g;s/amp;//g;/^$/d' | ChangeTimeZone | grep -Ev "todo.txt|done.txt"