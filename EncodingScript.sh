#!/bin/bash
# Frontend script for the enc_wo ("encoder waveout") program
holda=0; hold=0

if [[ $# -eq 0 ]]
then
 echo "You need to specify an input file"
 exit
fi
if [[ $# -gt 1 ]]
then
 echo "This script only accepts 1 argument (an input file)"
 exit
fi

echo "Starting"

if [[ -e miscfiles/encoder_input ]]
then
 echo "*** An encoder_input file exists. Moving it out of the way temporarily"
 let hold=1
 export holdfile=$RANDOM
 mv miscfiles/encoder_input miscfiles/hold_$holdfile
fi
if [[ -e miscfiles/PCMout.raw ]]
then
 echo "*** A PCMout.raw file exists. Moving it out of the way temporarily"
 let holda=1
 export holdfilea=$RANDOM
 mv miscfiles/PCMout.raw miscfiles/holda_$holdfilea
fi

cp $1 miscfiles/encoder_input
brandy -quit enc_wo
rm miscfiles/encoder_input
mv miscfiles/PCMout.raw _encoder_output_files/PCMout.raw_`date +%a%d%b%Y-%H\-%M-%S`

if [[ hold -eq 1 ]]
then
 echo "*** Restoring old encoder_input"
 mv miscfiles/hold_$holdfile miscfiles/encoder_input
fi
if [[ holda -eq 1 ]]
then
 echo "*** Restoring old PCMout.raw"
 mv miscfiles/holda_$holdfilea miscfiles/PCMout.raw
fi


echo "Ending"
