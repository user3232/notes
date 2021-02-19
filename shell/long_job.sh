#!/bin/sh
# long task writing dates to file scriptout
N=0 && while [ $N -lt 1000 ]
do date > scriptout # override, >> would append
N=`expr $N + 1`
done&