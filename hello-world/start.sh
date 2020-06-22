launch.sh
echo "ifconfig ens3 | grep 'inet' | cut -d ' ' -f 10 | awk 'NR==1{print $1}'"
echo [[HOST_IP]]
