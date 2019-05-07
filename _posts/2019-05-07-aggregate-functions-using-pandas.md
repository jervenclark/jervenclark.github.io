---
layout: default
titla: "Aggregate Functions using Pandas"
categories: "[data science, pandas, python]"
---

# Aggregate Functions using Pandas

Let's consider for a moment the csv file:

```csv
Name,            Population, Growth Rate, Density, Code
World,           7714576923, 1.07,        51.80,   -
Asia,            4584807072, 0.87,        102.85,  AS
S.C. Asia,       1986522007, 1.18,        192.36,  AS
S. Asia,         1913668492, 1.17,        299.00,  AS
E. Asia,         1659040770, 0.31,        143.51,  AS
Africa,          1320038716, 2.49,        43.57,   AF
Saharan Africa,  1078106193, 2.66,        45.65,   AF
Europe,          743102600,  0.06,        33.57,   EU
S.E. Asia,       662375294,  1.03,        152.60,  AS
Latin America,   658305557,  0.97,        34.29,   SA
E.Africa,        445447287,  2.72,        66.81,   AF
S. America,      431998475,  0.88,        24.22,   SA
W. Africa,       392176114,  2.67,        64.67,   AF
N. America,      366496802,  0.73,        14.83,   NA
E. Europe,       291391709,  -0.19,       16.14,   EU
W. Asia,         276869001,  1.68,        57.62,   AS
N. Africa,       241932523,  1.74,        31.14,   AF
Western Europe,  194663999,  0.30,        179.45,  EU
Central America, 181886939,  1.26,        347.26,  NA
Middle Africa,   173692967,  3.06,        26.74,   AF
Southern Europe, 151728253,  -0.09,       117.17,  EU
Northern Europe, 105318639,  0.53,        61.86,   EU
Central Asia,    72853515,   1.38,        18.20,   AS
Southern Africa, 66789825,   1.24,        25.20,   AF
Caribbean,       44420143,   0.60,        16.13,   SA
Oceania,         41826176,   1.37,        4.93,    OC
Melanesia,       10711929,   1.87,        20.23,   OC
Polynesia,       696623,     0.73,        86.11,   OC
Micronesia,      536579,     0.86,        766.54,  OC
The Middle East, 0,          0.00,        0.00,    AS
Antarctica,      0,          0.00,        0.00,    AN
```

It describes the name, population, growth rate density as well as the continent code per region. Let's begin by importing the csv file using panda

```python
import pandas as pd
population = pd.read_csv('population.csv', keep_default_na=False)
```

**What is the total population of Asia?**
```python
asia_population = population[population['Code'] == 'AS']["Population"].sum()
print(f'Total Population in Asia: {asia_population: ,}')

```
```
Total Population in Asia:  11,156,136,151.00
```


**What region has the highest growth rate and by what percent?***
```python
asia_growth_rate = population[population['Code'] == 'AS'][['Name', 'Growth Rate']].max()
print(f'The most populated regions is {asia_growth_rate["Name"]} with a population of {asia_growth_rate['Growth Rate']: ,.2f}%')

```
```

```
