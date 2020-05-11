i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
  read line

  total_mem="$(free -m | grep Mem.: | awk '{print $2}')"
  mem_usage="$(free -m | grep Mem.: | awk '{print $3}')"
  mem_usage_mb="$(free -h | grep Mem.: | awk '{print $3}' | sed "s/,/./")"
  mem_usage_percent="$((100*$mem_usage/$total_mem))"
  brilho_usage="$(brightness-nvidia -get)"

  rate="RAM: $mem_usage_mb, $mem_usage_percent%"
  brilho="◑: $brilho_usage"

  if [ $(echo "$mem_usage < 6000" | bc) -eq 1 ]
    then
        color=2ECC71
    else
        color=E74C3C
  fi

  echo ",[{\"full_text\":\"${brilho}\"},{\"full_text\":\"${rate}\" ,\"color\":\"#${color}\"}, ${line#,\[}" || exit 1
done)

