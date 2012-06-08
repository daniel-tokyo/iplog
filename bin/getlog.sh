if [ $# -ne 1 ]; then
    echo "\nPlease enter date(YYYYMMDD)!\n"
    exit 1
fi

mkdir -p logs

DAY="$1"
echo "Get ${DAY} log files ..."
for DT in $DAY; do
    scp "backup@122.209.125.38:/home/backup/data/sys/proxylb/$DT/*/*_apache.log.gz" ./logs/
done
exit 0
