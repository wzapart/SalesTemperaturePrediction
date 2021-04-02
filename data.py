#!/usr/bin/env python3
import numpy as np
import pandas as pd

data_shumee = pd.read_excel("data/shumee_mckinsey.xlsx")
print("Shumee data columns:")
print(data_shumee.columns)
print("%d rows" % data_shumee.shape[0])

#Filter Poland
data_shumee = data_shumee[data_shumee['Kraj'] == 'PL']
print("%d PL rows" % data_shumee.shape[0])

#split datetime
data_shumee['Data'] = pd.to_datetime(data_shumee['Data'])
print("Min date: %s" % str(data_shumee['Data'].min()))
print("Max date: %s" % str(data_shumee['Data'].max()))
data_shumee['Dzień'] = data_shumee['Data'].dt.day
data_shumee['Miesiąc'] = data_shumee['Data'].dt.month
data_shumee['Rok'] = data_shumee['Data'].dt.year

#Get distinct cities
data_shumee['Miasto'] = data_shumee['Miasto'].str.upper()
cities = data_shumee['Miasto'].unique().astype(str)
print("%d distinct cities" % cities.shape[0])

print(data_shumee.head())

data_weather = pd.read_csv("data/weather/k_d.csv")
print("Weather data (k_d) columns:")
print(data_weather.columns)
print("%d rows" % data_weather.shape[0])

#Merge data
#smart substring join. Found on https://stackoverflow.com/questions/50538051/perform-a-merge-based-on-a-substring-match
pat = "|".join(cities)
data_weather.insert(0, "Miasto", data_weather["Nazwa stacji"].str.extract("(" + pat + ")", expand=False)[0])

#We need only one measurement per day per city
data_weather.drop_duplicates(["Rok", "Miesiąc", "Dzień", "Miasto"])
print("%d unique measurements" % data_weather.shape[0])
print(data_weather.head())

#Finally merge datasets
data = pd.merge(data_shumee, data_weather, how='inner', on=["Rok", "Miesiąc", "Dzień", "Miasto"])
print("%d final data rows" % data.shape[0])
print(data.head())

data.to_csv("data/shumee_weather.csv")
