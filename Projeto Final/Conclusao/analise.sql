/*Qual o time com maior índice de vitórias?

SELECT ROUND(SUM(teams.win/(teams.win+teams.losses))*100,2) as WINRATE, teams.name
FROM dota2.teams 
GROUP BY teams.name
ORDER BY WINRATE DESC;
*/

/* Qual é o time com maior média de mmr?
SELECT DISTINCT(teams.name) as team_name, 
ROUND(AVG(players.mmr_estimate) OVER (PARTITION BY teams.name),2) as average_team_mmr
FROM dota2.team_players as team_player
INNER JOIN dota2.teams as teams
ON teams.id = team_player.team_id
INNER JOIN dota2.players as players
ON players.account_id = team_player.account_id
ORDER BY average_team_mmr DESC;
*/

/* Qual é o herói com maior número de vitórias tendo mais de 3 partidas jogadas?

SELECT REPLACE(heroes.name, 'npc_dota_hero_', '') as hero_name,
COUNT( matches_player.hero_id) as total_matches,
ROUND(SUM(CASE 
	WHEN player_slot < 128  and radiant_win = 1 THEN 1
    WHEN player_slot >=128 and radiant_win = 0 THEN 1
    ELSE 0
END) / COUNT( matches_player.hero_id)*100,2) as win_rate
FROM dota2.matches_player as matches_player
INNER JOIN dota2.heroes as heroes
ON heroes.id = matches_player.hero_id
GROUP BY hero_name
HAVING total_matches >= 4
ORDER BY total_matches DESC, win_rate DESC 

*/