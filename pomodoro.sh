#/bin/bash

#скрипт для работы c тайм-техникой помодоро,
#а также прекручивается к задачам в task

echo

WTIMEOUT=25 #Время по умолчанию

#Работа с аргументами
while [ -n "$1" ] #есть ли вообще аргументы
do
        case "$1" in
            #   -a) echo "Found the -a option"
            #   ;;
                -p) PAUSE="$2"
           	     echo "Pause is set $PAUSE minutes"
                #shift
                ;;
                -t) WTIMEOUT="$2"
                ;;
            #   --) shift
            #   break ;;
                #*) echo "$1 is not an option"
                #;;
esac
shift
done

DIR=`dirname "$0"`

#Массив с мельнецей
 
CH_S[0]='|'
CH_S[1]='\'
CH_S[2]='-'
CH_S[3]='/'
CH_S[4]='|'
CH_S[5]='\'
CH_S[6]='-'
CH_S[7]='/'

timer(){
task list
let "WSEC = WTIMEOUT * 60"
echo "Timer is set $WTIMEOUT minutes "
while [ $WSEC -ge 0 ];do
    #tput sc #сохраняем позицию курсора
    #let ""
    let "MIN = WSEC / 60"
    let "SEC = WSEC % 60"
    #printf '%11s : %s %s' $MIN $SEC "${CH_S[ITEM_ARR]}" # время и символ 'мельницы'
    for (( i=0; i <= 8; i++ ))
    do
	    tput sc
	    printf '%11s:%s  %2s' $MIN $SEC "${CH_S[$i]}"
	    tput rc
	    sleep 0.105
    done

    let "WSEC=WSEC-1" #уменьшаем время ожидания
done
 
#printf '\n'
mplayer $DIR'/doorbell.wav' 2&> /dev/null
}

message(){
	read -p "(P)ause/(C)ontinue/(E)xit: " PAUSE

}
pause(){
	if [ $# -eq 0 ]
	then
		PWSEC=300
		while [ $PWSEC -ge 0 ];do
			let "PMIN = PWSEC /60"
			let "PSEC = PWSEC % 60"
			for (( i=0; i <= 8; i++ ))
		     	do
             			tput sc
             			printf '%11s:%s  %2s' $PMIN $PSEC "${CH_S[$i]}"
             			tput rc
             			sleep 0.105
     			done

			let "PWSEC=PWSEC-1"
		done
	else
		echo $1
	fi
}

while true
do
timer
message

	if [[ "$PAUSE" == "p" ]];
		then
			echo "Relax"
			pause
			mplayer $DIR'/doorbell.wav' 2&> /dev/null
			read -p "Pause done. Press enter to continue  "
			clear
	elif [[ $PAUSE  == "c" ]];
		then
			clear
			echo "alter"
	else 
		exit
	fi
done
