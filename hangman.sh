#!/bin/bash

echo "ВИСЕЛИЦА"
word="бегемот" #загаданное слово
userword="_______" #ответ пользователя
current_userword=$userword

echo "В слове ${#word} букв"

set_tries() {
    echo "Количество попыток:"
    read tries
    if [ $tries -lt ${#word} ]
    then
	set_tries
    fi
}

is_win() {
    if [ $userword = $word ]
    then
	    echo "ПОБЕДА!";
        exit 0
    fi
}

set_tries

i=0
while [ $i -lt $tries ]
do
    echo "Введите букву"
    read letter

    grep -q $letter <<< $word #есть ли буква в слове?
    if [ $? -ne 0 ] #проверка exit code предыдущего действия
    then
	    echo "Такой буквы нет"
    else
        j=0;
        while [ $j -lt ${#word} ];
        do
            if [ ${word:$j:1} = $letter ]
            then
                current_userword=$userword;
                userword="${current_userword:0:j}$letter${current_userword:j+1:${#word}}";
            elif [[ ${userword:$j:1} = ${word:$j:1} ]]
            then
                current_userword=$userword;
                userword="${current_userword:0:j}${word:$j:1}${current_userword:j+1:${#word}}";
            fi
            j=$(( $j+1 ))
        done
    fi
    
    echo "СЛОВО - $userword"
    is_win

    i=$(( $i+1 ))
done
