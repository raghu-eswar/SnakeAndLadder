echo "enter number of players "; read noOfPlayers;
declare playerPlacesList;
leadingPlayer=0;
declare  playerStatusList;
numberOfChaces=0;

 # makes the all players to inetial state
start() {
    for ((i=1; i<=$noOfPlayers; i++))
    do
        playerPlacesList[$i]=0;
    done
}

 # gives chance to play all players and stores their places untill any one of player wins
multiPlayer() {
    start;
    while (( $leadingPlayer < 100))
    do
        playerStatusList=$1;
        numberOfChaces=$(( $numberOfChaces + 1 ));
        for ((i=1; i<=$noOfPlayers; i++))
        do
            play ${playerPlacesList[$i]};
            temp=$?;
            playerPlacesList[$i]=$temp;
            playerStatusList["$i, $numberOfChaces"]=$temp;
            if (( $leadingPlayer < $temp )); then
                leadingPlayer=$temp;
            fi
        done
    done
}

# rolles the die and return the player next plase acording to play state
play() { 
    playerPosition=$1;  
    dieValue=$(( ( RANDOM % 6 )  + 1 ));
    playStatus=$(( ( RANDOM % 5 ) - 1 ));
    if (( $playStatus > 1)); then
        playStatus=1;
    fi
    temp=$(( $playerPosition + $(($dieValue * $playStatus)) ));
    if (($temp < 0)); then
        playerPosition=0;
    elif (( $temp >= 100 )); then
        playerPosition=100;
    else
        playerPosition=$temp;
    fi
    return $playerPosition;
}

multiPlayer;

# out put
echo ${playerPlacesList[@]}
echo $numberOfChaces;