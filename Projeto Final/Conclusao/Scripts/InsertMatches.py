import pandas as pd
from apiConsume import *
from schemaConnection import *

dfMatches = pd.read_csv('matches.csv')
matches = dfMatches.to_dict('records')
matches = InsertMatchesIntoDataBase(matches)