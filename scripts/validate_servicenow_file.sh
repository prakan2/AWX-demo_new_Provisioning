#!/bin/bash
V_ticket=`cat ../final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]}
do
touch ../reports/${i}.txt 
echo -e "Below are the validation report for $i :\n">>../reports/${i}.txt
host=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
if [ -z $host ]
then
   echo -e "\tTicket $i doesnot have host information , getting from config file \n">>../reports/${i}.txt 
   wWn=`cat ../final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
   host=`grep -w $wWn ../config/config.txt | awk -F ':' '{print $1}'`
   echo -e "\tHOST server  in  action of $i : $host\n">>../reports/${i}.txt
else
   echo -e "\tHOST server  in  action of $i : $host \n">>../reports/${i}.txt
fi
echo -e "\tStorage group which is going to create: ${host}_SG \n">>../reports/${i}.txt
echo -e "\tInitiator group which is going to create: ${host}_IG \n">>../reports/${i}.txt
echo -e "\tMasking View which is going to create: ${host}_MV \n">>../reports/${i}.txt
Lun_size=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $2}' | awk -F ": '" '{ print $2}' | awk -F "GB'" '{print $1}'`
if [ -z $Lun_size ]
then
   echo -e "\tTicket $i doesnot have volume size information\n">>../reports/${i}.txt
else
   echo -e "\tSize of each volume requested :  $Lun_size GB\n">>../reports/${i}.txt
fi

Number_of_volume=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $4}' | awk -F "'" '{print $4}'`
if [ -z $Number_of_volume ]
then
   echo -e "\tTicket $i doesnot have number of volume\n">>../reports/${i}.txt
else
   echo -e "\tNumber of volume requested: $Number_of_volume\n">>../reports/${i}.txt
fi


Wwn=`cat ../final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
if [ -z $Wwn ]
then
   echo -e "\tTicket $i doesnot have WWN information , getting from config file\n">>../reports/${i}.txt
   wwn=`cat ../config/config.txt | grep -w $host | awk -F ":" '{print $2}'`
   echo -e "\tWWN for the host : $wwn\n">>../reports/${i}.txt
else 
   echo -e "\tWWN for the host : $Wwn\n">>../reports/${i}.txt
fi




done
