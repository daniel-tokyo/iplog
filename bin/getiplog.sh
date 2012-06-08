if [ $# -ne 1 ]; then
    echo ''
    echo 'Please enter the ips file!\n'
    echo ''
    exit 1
fi

mkdir -p iplog

FIP=$1
IPS="`awk '{printf $1 \" \"}' $FIP`"
FDS='20120527 20120531 20120601'
FHS='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23'

for IP in $IPS; do
    mkdir -p "./iplog/$IP"
done

for FDATE in $FDS; do
    for FHR in $FHS; do
        FName="proxylb_${FDATE}_${FHR}"
        FLOG="./logs/${FName}.log.gz"
        TLOG="./tmp/${FName}.log"
        echo "zcat $FLOG > $TLOG ..."
        zcat $FLOG > $TLOG
        for IP in $IPS; do
            IPLOG="iplog/${IP}/${FName}.log"
            echo "    grep $IP from $TLOG to $IPLOG ..."
            grep $IP $TLOG > $IPLOG &
        done
        echo '    wait ......'
        wait
        rm -f $TLOG
    done
done
echo 'Completed!'
exit 0
