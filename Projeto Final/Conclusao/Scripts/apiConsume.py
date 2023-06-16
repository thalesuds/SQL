import requests
import pandas as pd

def GetRegions(key : str) -> list:
    url = "https://api.opendota.com/api/constants/region"
    result = requests.get(url)

    return result.json()

def GetGameModes(key : str) -> list:
    url = "https://api.opendota.com/api/constants/game_mode"
    result = requests.get(url)

    return result.json()

def GetHeroes(key : str) -> list:
    url = "https://api.opendota.com/api/heroes"+key
    result = requests.get(url)

    return result.json()

def GetProfessionalTeams(key : str) -> requests:
    url = "https://api.opendota.com/api/teams"+key
    result = requests.get(url)

    if(result.status_code != 200):
        print("Team Functions: Invalid Request, status code: ", result.status_code)

    return result

def FilterProfessionalTeams(selectedTeams : list, teams : list) -> list:
    
    teamData = []

    for i in range(len(teams)):
        teamInfo = teams[i]

        if(teamInfo['name'] in selectedTeams):
            teamData.append(teamInfo)

    return teamData

def GetPlayersFromTeams(teamData : list, key : str) -> list:

    teamPlayers = []

    for i in range(len(teamData)):
        team = teamData[i]
        teamId = team['team_id']

        url = "https://api.opendota.com/api/teams/"+str(teamId)+"/players"+key
        result = requests.get(url)

        playersData = result.json()

        for i in range(len(playersData)):
            data = playersData[i]

            if data['is_current_team_member'] == True:
                data['team_id'] = teamId
                teamPlayers.append(data)

    return teamPlayers

def GetInfoFromTeamPlayers(teamPlayers : list, key : str) -> list:

    accounts = []

    for i in range(len(teamPlayers)):
        player = teamPlayers[i]
        account_id = player['account_id']
        url = "https://api.opendota.com/api/players/"+str(account_id)+key
        request = requests.get(url)
        accountInfo = request.json()

        accountInfo['account_id'] = account_id

        accounts.append(accountInfo)
    
    return accounts

def GetPlayersMatches(teamPlayers : list, key : str) -> list:
    matchesData = []
    for i in range(len(teamPlayers)):
        account = teamPlayers[i]['account_id']
        url = "https://api.opendota.com/api/players/"+str(account)+"/matches"+key
        result = requests.get(url)
        matches = result.json()

        if len(matches) >=10 and type(matches) == list:
            for j in range(10):
                match = matches[j]
                match['account_id'] = account
                matchesData.append(match)

        elif type(matches) == list:
            for j in range(len(matches)):
                match = matches[j]
                match['account_id'] = account
                matchesData.append(match)

        else:
             matchesData.extend(matches)

    return matchesData

def GetMatches(matchsIds : list, key : str) -> list:
    
    matches = []

    for i in range(len(matchsIds)):
        matchId = matchsIds[i]

        url = "https://api.opendota.com/api/matches/"+str(matchId)+key
        request = requests.get(url)

        details = request.json()

        matchDetails = {}
        matchDetails['match_id'] = str(matchId)
        matchDetails['game_id'] = details['game_mode']
        matchDetails['barracks_status_dire'] = details['barracks_status_dire']
        matchDetails['barracks_status_radiant'] = details['barracks_status_radiant']
        matchDetails['dire_score'] = details['dire_score']
        matchDetails['radiant_score'] = details['radiant_score']
        matchDetails['radiant_gold_adv'] = details['radiant_gold_adv']
        matchDetails['tower_status_dire'] = details['tower_status_dire']
        matchDetails['tower_status_radiant'] = details['tower_status_radiant']

        matches.append(matchDetails)

    return matches