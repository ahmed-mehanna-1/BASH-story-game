lines=""
ends=""
number_of_lines=""
question_length=10

function read_files () {
    number_of_lines=$(sed '/^$/d' questions.txt | wc -l)
    number_of_lines=$(($number_of_lines + 1))
    for ((i=1; i <= $number_of_lines; i++))
    do
        lines[$i]=$(sed '/^$/d' questions.txt | sed -n "$i"p)
    done
    local n=$(sed '/^$/d' ends.txt | wc -l)
    n=$(($number_of_lines + 1))
    for ((i=1; i <= $n; i++))
    do
        local line=$(sed '/^$/d' ends.txt | sed -n "$i"p)
        ends[${line/:*/}]=${line/*:/}
    done
}

function game_loop () {
    local score=0
    local total_fails=0
    local total_question_fails=0
    local total_passed=0
    local current_fails=0
    local index=1
    local last_index=1
    while ((index <= number_of_lines))
    do
        local ans=""
        echo -e '\033[0;35m'
        for ((i=$index; i <= (index + 3) & $i <= $number_of_lines; i++))
        do
            echo ${lines[$i]}
        done
        echo -ne '\033[0;34m'
        read -n1 -p "Your chooice: " ch 
        echo -e '\033[0;36m'
        case $ch in
        'c')
            ans=${lines[$((index + question_length - 4))]}
            ;;
        'b')
            ans=${lines[$((index + question_length - 5))]}
            ;;
        'a')
            ans=${lines[$((index + question_length - 6))]}
            ;;
        *)
            echo -ne '\033[0;31m'"da 2ly howa 2eh isa y3ne XD \n"
            continue
        esac
        echo -e ${ans:3:${#ans}}
        is_true=${ans:2:1}
        if [ $is_true = "t" ]
        then
            score=$((score+=1))
            total_passed=$((total_passed+=1))
            current_fails=0
            offset=${lines[$((index + question_length - 2))]}
        elif (( $current_fails < 1 ))
        then
            total_fails=$((total_fails+=1))
            current_fails=$((current_fails+=1))
            continue
        else
            total_fails=$((total_fails+=1))
            total_question_fails=$((total_question_fails+=1))
            current_fails=0
            echo -ne '\033[0;31m'${lines[$((index + question_length - 3))]}
            offset=${lines[$((index + question_length - 1))]}
        fi

        let index=$(( (${offset/*:/} - 1) * question_length + 1)) # offset * q_l - 9

        if (( $index == $last_index ))
        then
            echo ${ends[${offset/:*/}]}
            break
        else
            if [ $is_true = "f" ]
            then
                echo -e "\n"${ends[${offset/:*/}]}
            fi
            last_index=$index
        fi
    done
    echo -e '\033[0;34m'"\nPassed Questions: " $score "\nFail Questions: " $total_question_fails "\nTotal Fails: " $total_fails
}

clear
read_files
game_loop
