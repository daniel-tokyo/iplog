if [ $# -ne 1 ]; then
    echo "\nPlease enter date(YYYYMMDD)!\n"
    exit 1
fi

mkdir -p tmp/asd/log
mkdir -p tmp/asd/ip
DT=$1

echo 'Start ...'
TM='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23'
for HR in $TM; do
    FTEE="./tmp/asd/log/asd_${DT}_${HR}.log"
    FIP="./tmp/asd/ip/asd_${DT}_${HR}.ip"
    echo "grep asd.aima.jp to $FTEE and get ip to $FIP ..."
    zcat "./logs/proxylb_${DT}_${HR}.log.gz" | grep asd.aima.jp | tee $FTEE | awk '{print $1}' | sort -u > $FIP &
done
echo 'wait ......'
wait
FIP="./tmp/asd/asd_${DT}.ip"
cat ./tmp/asd/ip/asd_${DT}_*.ip | sort -u > $FIP
echo "The result in $FIP :"
cat $FIP
echo '---------------'
exit 0
