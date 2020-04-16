playerPosition1=0;
playerPosition2=0;
declare PlayerOneGameStatus;
declare PlayerTwoGameStatus;
PlayerOneGameStatus[0]=0;
PlayerTwoGameStatus[0]=0;
i=1;
playWithTwo() {
    play $playerPosition1 PlayerOneGameStatus;
    playerPosition1=$?;
    play $playerPosition2 PlayerTwoGameStatus;
    playerPosition2=$?;
    if (( $playerPosition1 < 100 && $playerPosition2 < 100 ));then
        playWithTwo;
    fi
}
play() { 
    playerPosition=$1;   
    local -n declare gameStatus=$2;
    dieValue=$(( ( RANDOM % 6 )  + 1 ));
    playStatus=$(( RANDOM % 5 ));
    case $playStatus in
        0)  
            echo "no play" ;
            dieValue=0 ;;
        1) 
            echo "snake";
            dieValue=$(( $dieValue * -1 )) ;;
        *) 
            echo "ladder" ;; 
    esac
    temp=$(( $playerPosition + $dieValue ));
    if (($temp < 0)); then
        playerPosition=0;
    elif (( $temp >= 100 )); then
        playerPosition=100;
    else
        playerPosition=$temp;
    fi
    gameStatus[$i]=$playerPosition;
    i=$(($i+1));
    return $playerPosition;
}

playWithTwo;
# out put------
echo "$playerPosition1 one position";
echo "$playerPosition2 two position";
echo "${PlayerOneGameStatus[@]} one status";
echo "${PlayerTwoGameStatus[@]} two status";
