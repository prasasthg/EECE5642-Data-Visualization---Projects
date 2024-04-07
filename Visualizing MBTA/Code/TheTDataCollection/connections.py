import pandas as pd

given_data = pd.read_html("file:///Users/prasasth/Downloads/HW4-code/data.html")

conn_table = given_data[1]
conn_table = conn_table.drop('#', axis=1)

conn_table.to_csv('connections.csv')
