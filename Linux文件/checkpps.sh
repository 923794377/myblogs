#!/bin/sh
#脚本功能：在指定网口收包超过某个pps时，自动抓取一定数量的包，存成一个文件，通常在不确定设备什么时候受到攻击或者流量异常的时候使用
#此脚本先放到 /tmp 下, 然后按如下步骤操作
#dos2unix /tmp/checkpps.sh
#chmod a+x /tmp/checkpps.sh
#cp /tmp/checkpps.sh /usr/sbin/
#(/usr/sbin/checkpps.sh eth0 10000 50000 &)   //注意，要带括号
#参数可自定义
#第一个表示要抓包的网口
#第二个表示收包的检测阀值，超过此数值就开始抓包
#第三个表示要抓多少包(默认值是只出10000包，另外有个超时值是6秒，意思是如果6秒内抓不够包，也会停止tcpdump)
#脚本的输出日志和抓到的包都放在 /aclog/checkpps_output/ 下面， 
#已对这个文件夹做了大小不限，不会超过2G，如果超过了，则会先删除一些数据包，然后再抓。
#所以不用担心抓的包过多，多大，占用太多磁盘空间。
#此外，要注意，如果重启了设备，则需要重新手动执行脚本，如果想启动就监控，请自行添加 /etc/rc2.d 下的启动脚本

echo "usage: ${0} [ifname] [max recv pps] [capture packet count]"

output_dir="/aclog/checkpps_output/"
[ ! -d ${output_dir} ] && mkdir -p ${output_dir}


#pps概念：每秒数据包个数
#注意包数和包大小不是一个概念，就是说pps和流量，带宽并不是相同概念，64字节以下的小包是一个包，大于1400字节的大包，也是一个包

#要抓包的网口，一般设置成内网口就行了
IFN=$1
echo "IFN="${IFN:="eth0"}

#检测间隔，每n秒检测一次pps，一般2或3秒可以了
SLEEP=2


#pps阀值设置：如果满足 “接收pps超过一定值” 或者 “接收但被drop的pps超过一定值” 两个条件之一，则启动抓包
#通常可以设置为实际正常上班时间网络接收pps的峰值的1.5到3倍就可以了
#比如早上10到11点eth0接收 pps是 10万 左右，那可以考虑设置成18万
#不过也要参考我们设备目前实际的性能指标，非10G版本6000平台，目前单桥单向数据一般也就是20多万的pps
#第二个条件drop包接收pps一般不需要管，设成一个较大的值就可以了（相当于忽略这条件）

RECV_PPS=$2
echo "RECV_PPS="${RECV_PPS:=10000}


#下面的参数是指启动抓包后，要抓多少个包才停止。
#注意不能抓太多，如果太多，可能文件会很大，占空间，也不好拷回来
#例如800Mbps的带宽（通常指下行，单向），1秒的数据包总大小，就是100MB左右了（除8，1字节等于8比特）
#可以根据实际正常的网络流量估算和估算的数据包大小，抓若干秒或几十秒的数据即可
#比如正常pps是2000，你可以抓10秒的数据，就是20000包，以每包1KB大包来算，大概就是10几MB
PKT_CNT=$3
echo "PKT_CNT="${PKT_CNT:=100000}

#抓包日志路径
LOGF=${output_dir}/${IFN}.log


LASTRX=0
LASTTX=0
LASTRB=0
LASTTB=0

START=0
END=0


RX_PACKTS="rx_packets:"
TX_PACKTS="tx_packets:"
RX_BYTES="rx_bytes:"
TX_BYTES="tx_bytes:"


#判断是否为万兆网卡
driver=`ethtool -i ${IFN} | grep "driver" | awk -F ":" '{ print $2 }'`
if [ ${driver} = "ixgbe" ] ; then
	RX_PACKTS="rx_pkts_nic:"
	TX_PACKTS="tx_pkts_nic:"
	RX_BYTES="rx_bytes_nic:"
	TX_BYTES="tx_bytes_nic:"
fi

loop=1

while :; do
	END=`date +%s%N`;
	flux_tmp=`ethtool -S ${IFN}`;
	CURRX=`echo ${flux_tmp} | awk -F ${RX_PACKTS} '{print $2}' | awk '{print $1}'`
	CURTX=`echo ${flux_tmp} | awk -F ${TX_PACKTS} '{print $2}' | awk '{print $1}'`
	CURRB=`echo ${flux_tmp} | awk -F ${RX_BYTES} '{print $2}' | awk '{print $1}'`
	CURTB=`echo ${flux_tmp} | awk -F ${TX_BYTES} '{print $2}' | awk '{print $1}'`

	#本次计算时间与上次计算的时间间隔
	let intertime=(${END} - ${START})/1000000;
	START=${END};

	let RX=$((${CURRX}-${LASTRX}))
	RX=$((${RX}*1000/${intertime}))

	let TX=$((${CURTX}-${LASTTX}))
	TX=$((${TX}*1000/${intertime}))

	let RB=$((${CURRB}-${LASTRB}))
	let RB/=1024
	RB=$((${RB}*1000/${intertime}))

	let TB=$((${CURTB}-${LASTTB}))
	let TB/=1024
	TB=$((${TB}*1000/${intertime}))


#	echo "PK/s: R=${RX}, T=${TX}        KB/s: R=${RB}, T=${TB}"

	if [ ${RX} -gt ${RECV_PPS} -a ${loop} -gt 1 ]; then
		echo "[ "`date "+%Y/%m/%d %H:%M:%S"`" ] PK/s: R=${RX}, T=${TX}        KB/s: R=${RB}, T=${TB}" >>${LOGF}

		#计算输出文件夹大小，如果太大了，先删除所有数据包
		#暂时设为 2G, 因为 aclog 分区还比较大
		outdir_size=`du -s ${output_dir} | awk '{print $1}'`
		#单位是KB
		if [ ${outdir_size} -gt 2048000 ]; then
			echo "${outdir_size} size ${outdir_size}KB, too big, delete packet" >>${LOGF}
			rm -f ${output_dir}/*.pcap
		fi
		#抓包文件路径
		tm=`date +%m%d_%H%M%S`
		CAPF=${output_dir}/${IFN}_${tm}.pcap
		tcpdump -i ${IFN} -s0 -c ${PKT_CNT} -w ${CAPF} &
		tcpdump_pid=$!
		sleep 6
		kill -INT ${tcpdump_pid}
	fi

	LASTRX=${CURRX}
	LASTTX=${CURTX}
	LASTRB=${CURRB}
	LASTTB=${CURTB}


	sleep ${SLEEP}
	let loop+=1
done

