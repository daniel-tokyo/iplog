if [ $# -ne 1 ]; then
    echo "\nPlease enter a date(YYYYMMDD)!\n"
    exit 1
fi

DT=$1
TM='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23'
for HR in $TM; do
    ORG="org/vsearch_proxylb_${DT}${HR}_192168115*"
    FILE="proxylb_${DT}_${HR}.log.gz"
    echo "Normalize $ORG to $FILE ..."
    zcat $ORG | gzip -c > $FILE
    if [ $? -eq 0 ]; then
        rm -fr $ORG
    else
        echo 'failed!'
        exit 2
    fi
done
exit 0
