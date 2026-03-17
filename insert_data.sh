#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# 1. Limpiamos las tablas antes de empezar (opcional, pero útil para pruebas)
echo $($PSQL "TRUNCATE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Saltamos la cabecera
  if [[ $YEAR != "year" ]]
  then
    
    # --- PASO 1: ASEGURAR QUE LOS EQUIPOS EXISTAN ---
    # Procesamos ambos equipos por igual
    for TEAM in "$WINNER" "$OPPONENT"
    do
      # Buscamos si el equipo ya existe
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM'")
      
      # Si no existe, lo insertamos
      if [[ -z $TEAM_ID ]]
      then
        INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM')")
        if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
        then
          echo "Inserted into teams: $TEAM"
        fi
      fi
    done

    # --- PASO 2: OBTENER LOS IDs (Ahora que sabemos que existen) ---
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # --- PASO 3: INSERTAR EL JUEGO ---
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted game: $YEAR, $ROUND ($WINNER vs $OPPONENT)"
    fi

  fi
done