import pandas as pd

given_data = pd.read_html("file:///Users/prasasth/Downloads/HW4-code/data.html")

station_table = given_data[0]
station_table = station_table.drop('#', axis=1)

station_table.to_csv('stations.csv')
