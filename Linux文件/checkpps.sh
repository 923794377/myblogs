#!/bin/sh
#�ű����ܣ���ָ�������հ�����ĳ��ppsʱ���Զ�ץȡһ�������İ������һ���ļ���ͨ���ڲ�ȷ���豸ʲôʱ���ܵ��������������쳣��ʱ��ʹ��
#�˽ű��ȷŵ� /tmp ��, Ȼ�����²������
#dos2unix /tmp/checkpps.sh
#chmod a+x /tmp/checkpps.sh
#cp /tmp/checkpps.sh /usr/sbin/
#(/usr/sbin/checkpps.sh eth0 10000 50000 &)   //ע�⣬Ҫ������
#�������Զ���
#��һ����ʾҪץ��������
#�ڶ�����ʾ�հ��ļ�ֵⷧ����������ֵ�Ϳ�ʼץ��
#��������ʾҪץ���ٰ�(Ĭ��ֵ��ֻ��10000���������и���ʱֵ��6�룬��˼�����6����ץ��������Ҳ��ֹͣtcpdump)
#�ű��������־��ץ���İ������� /aclog/checkpps_output/ ���棬 
#�Ѷ�����ļ������˴�С���ޣ����ᳬ��2G����������ˣ������ɾ��һЩ���ݰ���Ȼ����ץ��
#���Բ��õ���ץ�İ����࣬���ռ��̫����̿ռ䡣
#���⣬Ҫע�⣬����������豸������Ҫ�����ֶ�ִ�нű�������������ͼ�أ���������� /etc/rc2.d �µ������ű�

echo "usage: ${0} [ifname] [max recv pps] [capture packet count]"

output_dir="/aclog/checkpps_output/"
[ ! -d ${output_dir} ] && mkdir -p ${output_dir}


#pps���ÿ�����ݰ�����
#ע������Ͱ���С����һ���������˵pps������������������ͬ���64�ֽ����µ�С����һ����������1400�ֽڵĴ����Ҳ��һ����

#Ҫץ�������ڣ�һ�����ó������ھ�����
IFN=$1
echo "IFN="${IFN:="eth0"}

#�������ÿn����һ��pps��һ��2��3�������
SLEEP=2


#pps��ֵ���ã�������� ������pps����һ��ֵ�� ���� �����յ���drop��pps����һ��ֵ�� ��������֮һ��������ץ��
#ͨ����������Ϊʵ�������ϰ�ʱ���������pps�ķ�ֵ��1.5��3���Ϳ�����
#��������10��11��eth0���� pps�� 10�� ���ң��ǿ��Կ������ó�18��
#����ҲҪ�ο������豸Ŀǰʵ�ʵ�����ָ�꣬��10G�汾6000ƽ̨��Ŀǰ���ŵ�������һ��Ҳ����20�����pps
#�ڶ�������drop������ppsһ�㲻��Ҫ�ܣ����һ���ϴ��ֵ�Ϳ����ˣ��൱�ں�����������

RECV_PPS=$2
echo "RECV_PPS="${RECV_PPS:=10000}


#����Ĳ�����ָ����ץ����Ҫץ���ٸ�����ֹͣ��
#ע�ⲻ��ץ̫�࣬���̫�࣬�����ļ���ܴ�ռ�ռ䣬Ҳ���ÿ�����
#����800Mbps�Ĵ���ͨ��ָ���У����򣩣�1������ݰ��ܴ�С������100MB�����ˣ���8��1�ֽڵ���8���أ�
#���Ը���ʵ��������������������͹�������ݰ���С��ץ�������ʮ������ݼ���
#��������pps��2000�������ץ10������ݣ�����20000������ÿ��1KB������㣬��ž���10��MB
PKT_CNT=$3
echo "PKT_CNT="${PKT_CNT:=100000}

#ץ����־·��
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


#�ж��Ƿ�Ϊ��������
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

	#���μ���ʱ�����ϴμ����ʱ����
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

		#��������ļ��д�С�����̫���ˣ���ɾ���������ݰ�
		#��ʱ��Ϊ 2G, ��Ϊ aclog �������Ƚϴ�
		outdir_size=`du -s ${output_dir} | awk '{print $1}'`
		#��λ��KB
		if [ ${outdir_size} -gt 2048000 ]; then
			echo "${outdir_size} size ${outdir_size}KB, too big, delete packet" >>${LOGF}
			rm -f ${output_dir}/*.pcap
		fi
		#ץ���ļ�·��
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

