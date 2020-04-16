echo "Welcome";

playerPosition=0;
while ((playerPosition < 100))
do
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
done
# out put
echo $playerPosition;