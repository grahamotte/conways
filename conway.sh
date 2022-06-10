#!/usr/bin/env bash

# bash conway.sh
# Don't complain that the screwdriver sucks at driving a nail into the wall.

export IFS=$'\n'
size=10
declare -A board

for ((r=1;r<=$size;r++)); do
    for ((c=1;c<=$size;c++)); do
        board[$r,$c]=$(($RANDOM%2))
    done
done

function print_board {
    for ((r=1;r<=$size;r++)); do
        line=''
        for ((c=1;c<=$size;c++)); do
            if (( ${board[$r,$c]} )); then
                line+='# '
            else
                line+='. '
            fi
        done
        echo $line
    done
    echo
}

function live_or_die {
    local neighbors=(
        ${board[$(( $1 + 0 % $size )),$(( $2 + 1 % $size ))]}
        ${board[$(( $1 + 0 % $size )),$(( $2 - 1 % $size ))]}
        ${board[$(( $1 + 1 % $size )),$(( $2 + 0 % $size ))]}
        ${board[$(( $1 - 1 % $size )),$(( $2 + 0 % $size ))]}
        ${board[$(( $1 + 1 % $size )),$(( $2 + 1 % $size ))]}
        ${board[$(( $1 - 1 % $size )),$(( $2 - 1 % $size ))]}
        ${board[$(( $1 + 1 % $size )),$(( $2 - 1 % $size ))]}
        ${board[$(( $1 - 1 % $size )),$(( $2 + 1 % $size ))]}
    )

    local count_neighbors=`IFS=$'\n'; echo "${neighbors[*]}" | grep 1 | wc -l | xargs`
    local cell=${board[$1,$2]}

    if (( $cell == 1 )); then
        echo $(( $count_neighbors == 2 || $count_neighbors == 3 ))
    else
        echo $(( $count_neighbors == 3 ))
    fi
}

function tick {
    declare -A new_board

    for ((r=1;r<=$size;r++)); do
        for ((c=1;c<=$size;c++)); do
            new_board[$r,$c]=`live_or_die $r $c`
        done
    done

    for ((r=1;r<=$size;r++)); do
        for ((c=1;c<=$size;c++)); do
            board[$r,$c]=${new_board[$r,$c]}
        done
    done

    board=$new_board
}

for _ in {1..10}; do
    tick
    print_board
done
