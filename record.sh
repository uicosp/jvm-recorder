pid=$1

if [[ $pid == '' ]]; then
    echo '请指定 pid'
    exit
fi

echo ">>> 开始保存 jvm 现场信息 <<<"

# get home dir
home_dir=`eval echo "~$USER"`

# create log dir
version=$(date '+%Y%m%d%H%M%S')
log_dir="$home_dir/record/$version"
mkdir -p $log_dir

echo '记录 jinfo 信息...'
jstat -gcutil $pid > "$log_dir/jstat.txt"

echo "记录 jmap -heap 信息..."
jmap -heap $pid > "$log_dir/jmap_heap.txt"

echo "记录 jmap -histo 信息..."
jmap -histo $pid > "$log_dir/jmap_histo.txt"

echo "记录 jstack 信息..."
jstack $pid > "$log_dir/jstack.txt"

echo "记录 free 信息..."
free -h > "$log_dir/free.txt"

echo "记录 top 信息..."
top -p $pid -b -n 1 > "$log_dir/top.txt"

echo ">>> 现场信息已保存至 $log_dir <<<"

