#!/bin/bash
 
WTIMEOUT=120 #Время ожидания
ITEM_ARR=0  #Счетчик для текущего элемента массива
 
CH_S[0]='-' #Массив с символами 'мельницы'
CH_S[1]='/'
CH_S[2]='|'
CH_S[3]='\'
 
while [ $WTIMEOUT -ge 0 ];do
    tput sc #сохраняем позицию курсора
    let "MIN = WTIMEOUT / 60"
    let "SEC = WTIMEOUT % 60"
    printf '%5s : %s %s' $MIN $SEC "${CH_S[ITEM_ARR]}" #выводим время и текущий символ 'мельницы'
    tput rc #восстанавливаем позицию курсора
    sleep 1
    let "WTIMEOUT=WTIMEOUT-1" #уменьшаем время ожидания
    let "ITEM_ARR=ITEM_ARR+1" #прибавляем счетчик элементов массива
    if [ $ITEM_ARR -eq 4 ]; then #если счетчик = 4
        let "ITEM_ARR=0" #обнуляем его, чтоб опять начать с 1 эл-та 'мельницы'
    fi
done
 
printf '\n'
