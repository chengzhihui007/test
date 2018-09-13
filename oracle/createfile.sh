#!/bin/sh
sqlplus  'yoyi1606/"yoyi$#1606"'@YYZF_TEST<<EOF
set define off
set hea off
spool temp.txt
select MUN_CHANNELNO from (select MUN_CHANNELNO from mer_union un inner join mer_cst_inf mer on un.mun_cstno = mer.mcf_cstno inner join mer_acc_inf acc on mer.mcf_cstno = acc.maf_cstno where un.mun_agent = 'M100002565' and acc.maf_acctype = '21') where rownum <11;
spool off
exit
EOF
sed -i 's/[ ]*//g' temp.txt
sed -i '/^$/d' temp.txt
sed -i '1d' temp.txt
sed -i '$d' temp.txt
sed -i '$d' temp.txt

if [ $? -eq 0 ]; then
   row=`wc -l < temp.txt`
for ((i =1;i <= $row;i=i+1))
do
onerow=`sed -n "$i"p < temp.txt`
for (( j =1; j <=10;j=j+1))
do
echo  $onerow,DD$(date +%Y%m%d%H%M%S%N),DD$(date +%Y%m%d%H%M%S%N),0.01,CNY,989,,20180630113304,20180630,,101.254.101.2,665C,0.00,0,0,www.qq.com>>$j.txt
done
done

else
    echo "failed"
fi
