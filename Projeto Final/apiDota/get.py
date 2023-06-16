import pandas as pd
from apiConsume import *
from schemaConnection import *

dfPlayersMatches = pd.read_csv('playersMatches.csv')
matches = dfPlayersMatches.to_dict('records')
matches = InsertPlayersMatchesIntoDataBase(matches)