#!/bin/bash
NagiosPluginsDir=/usr/lib/nagios/plugins
if [ ! -f $NagiosPluginsDir/LastDataOut.txt ]
then
	touch $NagiosPluginsDir/LastDataOut.txt
	echo "0" > $NagiosPluginsDir/LastDataOut.txt
fi

CurrentDataOut=$(echo $(($(cat /proc/net/dev  | grep eth | awk '{print $2+$10}')/2**20)))
LastDataOut=`cat $NagiosPluginsDir/LastDataOut.txt`
DataOut=$(($CurrentDataOut - $LastDataOut))
echo $CurrentDataOut > $NagiosPluginsDir/LastDataOut.txt

echo "Network dataout in last 5 minute is: $DataOut | DataOut=${DataOut}B;2048000;4096000;0;${DataOut}"
exit 0
