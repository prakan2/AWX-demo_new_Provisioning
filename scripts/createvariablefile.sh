V_ticket=`cat ../final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]}
do
  V_host=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
  Wwn=`cat ../final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
  if [ -z $V_host ] 
  then
  V_host=`grep -w $Wwn ../config/config.txt | awk -F ':' '{print $1}'`
  fi
  if [ -z $Wwn ]
  then
  Wwn=`cat ../config/config.txt | grep -w $V_host | awk -F ":" '{print $2}'`
  fi

  touch ../var_file/${i}.yaml
  echo "Ticket: $i">>../var_file/${i}.yaml
#  V_host=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
  echo "hostname: $V_host">>../var_file/${i}.yaml
  Lun_size=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $2}' | awk -F ": '" '{ print $2}' | awk -F "GB'" '{print $1}'`
  echo "volume_size: $Lun_size">>../var_file/${i}.yaml
  Number_of_volume=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $4}' | awk -F "'" '{print $4}'`
  echo "num_of_vols: $Number_of_volume">>../var_file/${i}.yaml
#  Wwn=`cat ../final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
  echo "init: [$Wwn]">>../var_file/${i}.yaml
  Alias_port=`echo "$Wwn" | sed -e $'s/,/ /g'`
  array=($Alias_port)
  Alias=""
  cnt=${#array[@]}
  for ((j=0;j<cnt;j++));do
    array[j]="hba$j"
    Alias+=",${array[j] }"
    done
  V_alias=`echo $Alias | sed 's/,//'`
  echo "alias_port: [$V_alias]">>../var_file/${i}.yaml
  echo "hostId: ${V_host}_IG">>../var_file/${i}.yaml
  echo "maskingViewId: ${V_host}_MV">>../var_file/${i}.yaml
  echo "storageGroupId: ${V_host}_SG">>../var_file/${i}.yaml
  echo "remote_storage_group: ${V_host}_SG">>../var_file/${i}.yaml
  echo "Password: smc">>../var_file/${i}.yaml
  echo "Username: smc">>../var_file/${i}.yaml
  echo "unisphere_url: 'https://10.241.210.217:8443'">>../var_file/${i}.yaml
  echo "sloId: Diamond">>../var_file/${i}.yaml
  echo "srpId: SRP_1">>../var_file/${i}.yaml
  echo "symmetrixId: 000197600361">>../var_file/${i}.yaml
  echo "remoteSymmId: 000197600362">>../var_file/${i}.yaml
  echo "portgroup: Unisphere_2_PG">>../var_file/${i}.yaml
  echo "smtp_server: mailhub.lss.emc.com">>../var_file/${i}.yaml
  echo "email_id: nishu.prakash@emc.com">>../var_file/${i}.yaml
done
