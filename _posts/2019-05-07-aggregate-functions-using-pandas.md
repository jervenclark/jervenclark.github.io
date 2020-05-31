---
title: "Aggregate Functions using Pandas"
date: 2019-05-07 18:20:44 +08:00
modified: 2019-05-07 18:20:44 +08:00
description:
series:
archived: true
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

# filter by continent code
asia = population['Code'] == 'AS'
```

**Describe the dataset**
```
print(population.describe())
```

Result:
```
         Population  Growth Rate  Pop Density
count  3.100000e+01    31.000000    31.000000
mean   8.326446e+08     1.133871    98.208065
std    1.578766e+09     0.888518   149.729255
min    0.000000e+00    -0.190000     0.000000
25%    6.982167e+07     0.565000    22.225000
50%    2.768690e+08     1.030000    45.650000
75%    7.027389e+08     1.530000   110.010000
max    7.714577e+09     3.060000   766.540000
```

**What is the total population of Asia?**
```python
asia_population = population[asia]["Population"].sum()
print(f'Total Population in Asia: {asia_population: ,}')
```

Result:
```
Total Population in Asia:  11,156,136,151.00
```


**What region has the highest growth rate and by what percent?***
```python
asia_growth_rate = population[asia][['Name', 'Growth Rate']].max()
print(f'The most populated regions is {asia_growth_rate["Name"]}')
print(f'With a rate of {asia_growth_rate["Growth Rate"]: ,.2f}%')
```

Result:
```
The most populated regions is Western Asia
With a population of  1.68%
```

**List the top 3 sub regions per continent**
```python
top_regions = population.groupby('Code').head(3)
print(top_regions.reset_index(drop=True))
```

Result:
```
                  Name  Population  Growth Rate  Pop Density Code
0                World  7714576923         1.07        51.80    -
1                 Asia  4584807072         0.87       102.85   AS
2   South Central Asia  1986522007         1.18       192.36   AS
3        Southern Asia  1913668492         1.17       299.00   AS
4               Africa  1320038716         2.49        43.57   AF
5   Sub Saharan Africa  1078106193         2.66        45.65   AF
6               Europe   743102600         0.06        33.57   EU
7        Latin America   658305557         0.97        34.29   SA
8       Eastern Africa   445447287         2.72        66.81   AF
9        South America   431998475         0.88        24.22   SA
10       North America   366496802         0.73        14.83   NA
11      Eastern Europe   291391709        -0.19        16.14   EU
12      Western Europe   194663999         0.30       179.45   EU
13     Central America   181886939         1.26       347.26   NA
14           Caribbean    44420143         0.60        16.13   SA
15             Oceania    41826176         1.37         4.93   OC
16           Melanesia    10711929         1.87        20.23   OC
17           Polynesia      696623         0.73        86.11   OC
18          Antarctica           0         0.00         0.00   AN
```
**What is the total population per continent**
```python
top_regions_total = population.groupby('Code').sum()
print(top_regions_total)
```
Result:
```
       Population  Growth Rate  Pop Density
Code
-      7714576923         1.07        51.80
AF     3718183625        16.58       303.78
AN              0         0.00         0.00
AS    11156136151         7.62       966.14
EU     1486205200         0.61       408.19
NA      548383741         1.99       362.09
OC       53771307         4.83       877.81
SA     1134724175         2.45        74.64
```

**How many sub regions are there per continent?**
```python
subregion_count = population['Code'].value_counts()
print(subregion_count)
```

Result:
```
AS    8
AF    7
EU    5
OC    4
SA    3
NA    2
AN    1
-     1
```
