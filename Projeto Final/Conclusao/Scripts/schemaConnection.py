import mysql.connector
import numpy as np
import ast

def CreateConnection():
    connection = mysql.connector.connect(user='root', password='Xproa700##',
                              host='localhost',
                              database='dota2')

    return connection

def InsertRegionsIntoDataBase(regions : dict):
    connection = CreateConnection()
    cursor = connection.cursor()
    addRegion = ("INSERT INTO region"
                "(id , name)"
                "VALUES (%s, %s)")
    
    try: 
        for key in regions.keys():
            regionData = (int(key), regions[key])
            cursor.execute(addRegion, regionData)
        
        connection.commit()
        cursor.close()
        connection.close()
    
    except:
        cursor.close()
        connection.close()

def InsertGameModesIntoDataBase(gameModes : dict):

    connection = CreateConnection()
    cursor = connection.cursor()
    addGameMode = ("INSERT INTO game_mode"
                "(id , name, balanced)"
                "VALUES (%s, %s, %s)")
    
    try: 
        for key in gameModes.keys():
            
            gameMode = gameModes[key]
            id = gameMode['id']
            name = gameMode['name']

            if 'balanced' in gameMode:
                balanced = gameMode['balanced']
            else:
                balanced = False

            gameModeData = (id, name, balanced)
            cursor.execute(addGameMode, gameModeData)
        
        connection.commit()
        cursor.close()
        connection.close()
    
    except:
        cursor.close()
        connection.close()


def InsertHerosIntoDataBase(heroes : list):
    connection = CreateConnection()
    cursor = connection.cursor()
    addHero = ("INSERT INTO heroes"
                "(id , name)"
                "VALUES (%s, %s)")
    
    try: 
        for i in range(len(heroes)):
            hero = heroes[i]
            heroData = (hero['id'], hero['name'])
            cursor.execute(addHero, heroData)
        
        connection.commit()
        cursor.close()
        connection.close()
    
    except:
        cursor.close()
        connection.close()


def InsertTeamsIntoDataBase(teams : list):
    connection = CreateConnection()
    cursor = connection.cursor()
    addTeam = ("INSERT INTO teams"
               "(id, name, win, losses)"
               "VALUES (%s, %s, %s, %s)")
    try:
        for i in range(len(teams)):
            team = teams[i]
            teamData = (team['team_id'], team['name'], team['wins'], team['losses'])
            cursor.execute(addTeam, teamData)
        
        connection.commit()
        cursor.close()
        connection.close()
    except:
        cursor.close()
        connection.close()

def InsertTeamPlayersIntoDataBase(players : list):
    connection = CreateConnection()
    cursor = connection.cursor()

    addPlayer = ("INSERT INTO team_players"
                 "(account_id, team_id, player_name, games_player, win, current_team_member)"
                 "VALUES (%s, %s, %s, %s, %s, %s)")
    try:
        for i in range(len(players)):
            player = players[i]
            playerData = (player["account_id"], player['team_id'], player['name'], player['games_played'], player['wins'], player['is_current_team_member'])
            cursor.execute(addPlayer, playerData)

        connection.commit()
        cursor.close()
        connection.close()
    
    except:
        cursor.close()
        connection.close()

def InsertMatchesIntoDataBase(matches : list):
    connection = CreateConnection()
    cursor = connection.cursor()

    addMatches = ("INSERT INTO matches"
                 "(id, game_id, barracks_status_dire, barracks_status_radiant, dire_score, radiant_score, radiant_gold_adv, tower_status_dire, tower_status_radiant)"
                 "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)") 

    try:
        for i in range(len(matches)):    
            details = matches[i]

            id = str(details['match_id'])
            gameId = details['game_id'] if np.isnan(float(details['game_id'])) == False else 0
            barracksStatusDire = details['barracks_status_dire'] if np.isnan(float(details['barracks_status_dire'])) == False else 0
            barracksStatusRadiant = details['barracks_status_radiant'] if np.isnan(float(details['barracks_status_radiant'])) == False else 0
            direScore = details['dire_score'] if np.isnan(float(details['dire_score'])) == False else 0
            radiantScore = details['radiant_score'] if np.isnan(float(details['radiant_score'])) == False else 0
            
            radiantGoldAdv = 0

            if type(details['radiant_gold_adv']) == str:
                radiantGoldAdv = ast.literal_eval(details['radiant_gold_adv'])
                radiantGoldAdv = radiantGoldAdv[len(radiantGoldAdv)-1] if np.isnan(float(radiantGoldAdv[len(radiantGoldAdv)-1])) == False else 0
            
            towerStatusDire = details['tower_status_dire'] if np.isnan(float(details['tower_status_dire'])) == False else 0
            towerStatusRadiant = details['tower_status_radiant'] if np.isnan(float(details['tower_status_radiant'])) == False else 0

            matchesData = (id, gameId, barracksStatusDire, barracksStatusRadiant, direScore, 
                           radiantScore, radiantGoldAdv, towerStatusDire, towerStatusRadiant)
            
            cursor.execute(addMatches, matchesData)
        
        connection.commit()
        cursor.close()
        connection.close()
    
    except Exception as e:
        print(e)
        cursor.close()
        connection.close()

def InsertPlayersMatchesIntoDataBase(matches : list):
    connection = CreateConnection()
    cursor = connection.cursor()

    addMatches = ("INSERT INTO matches_player"
                 "(match_id, account_id, hero_id, game_id, player_slot, radiant_win, duration, kills, deaths, assists, average_rank)"
                 "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")   
    try:
        for i in range(len(matches)):
            match = matches[i]
            id = str(match['match_id'])
            account_id = match['account_id'] if np.isnan(float(match['account_id'])) == False else 0
            hero_id = match['hero_id'] if np.isnan(float(match['hero_id'])) == False and match['hero_id'] != 0 else 1
            game_id = match['game_mode'] if np.isnan(float(match['game_mode'])) == False else 0
            player_slot = match['player_slot'] if np.isnan(float(match['player_slot'])) == False else 0
            radiant_win = match['radiant_win'] if np.isnan(float(match['radiant_win'])) == False else 0
            duration = match['duration'] if np.isnan(float(match['duration'])) == False else 0
            kills = match['kills'] if np.isnan(float(match['kills']))== False else 0
            deaths = match['deaths'] if np.isnan(float(match['deaths'])) == False else 0
            assists = match['assists'] if np.isnan(float(match['assists'])) == False else 0
            average_rank = match['average_rank'] if np.isnan(float(match['average_rank'])) == False else 0
            
            matchData = (id, account_id, hero_id, game_id, player_slot, radiant_win, duration, kills, deaths, assists, average_rank)

            cursor.execute(addMatches, matchData)

        connection.commit()
        cursor.close()
        connection.close()
    
    except Exception as e:
        print(e)
        print(matchData)
        cursor.close()
        connection.close()

    