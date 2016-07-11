#!/bin/bash
tmp=/tmp/
if [ ! -f $tmp/LastDataOut.txt ]
then
	touch $tmp/LastDataOut.txt
	echo "0" > $tmp/LastDataOut.txt
fi

CurrentDataOut=$(echo $(($(cat /proc/net/dev  | grep eth | awk '{print $2+$10}'))))
LastDataOut=`cat $tmp/LastDataOut.txt`
DataOut=$(($CurrentDataOut - $LastDataOut))
echo $CurrentDataOut > $tmp/LastDataOut.txt

echo "Network dataout in last 5 minute is: $DataOut | DataOut=${DataOut}B;2048000;4096000;0;${DataOut}"
exit 0
