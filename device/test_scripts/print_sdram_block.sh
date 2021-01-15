i=0
while [ $i -le 63 ]
do
    base=$((0x30000000))
    addr=$(( i + base ))
    #printf '%x\n' $addr
    echo `devmem2 $addr w | awk 'FNR == 3 {print $6}'`
    i=$(( $i + 4 ))
done
