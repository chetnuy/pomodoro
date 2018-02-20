#/bin/bash


#скрипт для работы c тайм-техникой помодоро,
#а также прекручивается к задачам в task




#Работа с аргументами
while [ -n "$1" ] #есть ли вообще аргументы
do
        case "$1" in
                -a) echo "Found the -a option"
                ;;
                -p) param="$2"
                echo "Пауза включена на $param мин"
                #shift
                ;;
                -t) timer="$2"
			echo "Taймер становлен на $timer мин "
                ;;
                --) shift
                break ;;
                #*) echo "$1 is not an option"
                #;;
esac
shift
done

#параметры паузы
if [ -n "$param" ]
then
	sec=$(($param * 60))
	sleep $sec

fi


echo
echo POMODORO_TIMER 25 minut working 
task list

if [ -n "$timer" ]
then
	echo тимер пошел
	sleep $(($timer * 60))
else
	echo дефолт
	sleep 1500
fi

mplayer doorbell.wav 2&> /dev/null
