#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guessing_game -t --no-align --tuples-only -c"

# generate random number
RANDOM_NUMBER=$(($RANDOM % 1000 + 1)) 
echo $RANDOM_NUMBER
# if set to one this is user first game
USER_FIRST_GAME=0

# ask for a username
echo -e "Enter your username:"
read USERNAME
# sql query to check if the name exist in the database
NAME_IN_THE_DATABASE=$($PSQL "SELECT username FROM player WHERE username = '$USERNAME'")
if [[ -z $NAME_IN_THE_DATABASE ]]; then
  # if not in the database
  USER_FIRST_GAME=1
  $PSQL "INSERT INTO player(username) VALUES('$USERNAME');"
  $PSQL "UPDATE player SET games_played=0 WHERE username='$USERNAME'"
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  else
  # print information from database, games_played, best_game
  #tr use because it returned values with '\n'
  GAMES_PLAYED=$(($PSQL "SELECT games_played FROM player WHERE username='$USERNAME'") | tr -d '\n')
  BEST_GAME=$(($PSQL "SELECT number_of_guesses FROM games INNER JOIN player ON games.game_id=player.best_game_id WHERE username='$USERNAME'") | tr -d '\n')
  
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo -e "Guess the secret number between 1 and 1000:"
read USER_GUESS
# loop until the user guesses the number
NUMBER_OF_TRIES=1
while [[ ! $RANDOM_NUMBER -eq $USER_GUESS ]]
do
NUMBER_OF_TRIES=$(($NUMBER_OF_TRIES + 1))
# check if the input is a number
# returns true if this is a number, false otherwise
if [[ $USER_GUESS =~ ^[0-9]+$ ]]; then
  # check if the user number is higher
  if [[ $USER_GUESS -gt $RANDOM_NUMBER ]]; then
    echo -e "It's lower than that, guess again:"
    read USER_GUESS
  # check if the user number is lower
  elif [[ $USER_GUESS -lt $RANDOM_NUMBER ]]; then
    echo -e "It's higher than that, guess again:"
    read USER_GUESS
  fi

else
  echo -e "That is not an integer, guess again:"
  read USER_GUESS
fi
done
# if user guessed the number
if [[ $USER_GUESS -eq $RANDOM_NUMBER ]]; then
    # insert game statistics into games table
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(number_of_guesses, winning_number) VALUES($NUMBER_OF_TRIES, $RANDOM_NUMBER)")
    # get current game_id
  CURRENT_GAME_ID=$($PSQL "SELECT game_id FROM games WHERE number_of_guesses=$NUMBER_OF_TRIES AND winning_number=$RANDOM_NUMBER")
    # check if this is first game of the user, if yes then add this game as his best
  #CHECK_IF_USER_HAVE_BEST_GAME_ID=$($PSQL "SELECT best_game_id FROM player WHERE username='$USERNAME'")
  if [[ $USER_FIRST_GAME -eq 1 ]]; then
    UPDATE_USER_BEST_GAME_ID=$($PSQL "UPDATE player SET best_game_id=$CURRENT_GAME_ID, games_played = games_played + 1   WHERE username='$USERNAME'")
  else
    # incerement games_played in player table
    INCREMENT_GAMES_PLAYED=$($PSQL "UPDATE player SET games_played = games_played + 1 WHERE username = '$USERNAME'")
    # get user number of tries from best game
    USER_BEST_GAME_NUMBER_TRIES=$($PSQL "SELECT number_of_guesses FROM games INNER JOIN player ON game_id=best_game_id WHERE player.best_game_id=game_id AND username='$USERNAME'")
  
    # compare best game with current game
    # if this was the best game change user best_game_id
    if [[ $NUMBER_OF_TRIES -lt $USER_BEST_GAME_NUMBER_TRIES ]]; then
    #  USER_BEST_GAME_ID=$($PSQL "SELECT game_id FROM games INNER JOIN player ON game_id=best_game_id WHERE player.best_game_id=$CURRENT_GAME_ID")
     UPDATE_USER_BEST_GAME=$($PSQL "UPDATE player SET best_game_id=$CURRENT_GAME_ID WHERE username='$USERNAME'")
    fi 
  fi   
  
    echo -e "You guessed it in $NUMBER_OF_TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"
    exit
fi
