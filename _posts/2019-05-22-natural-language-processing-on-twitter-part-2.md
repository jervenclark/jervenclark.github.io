---
title: "Natural Language Processing on Twitter - Part 2"
date: 2019-05-22 16:37:38 +08:00
modified: 2019-05-22 16:37:38 +08:00
tags: [data-science, pandas, python, nltk, tweepy]
description: 
---

# Natural Language Processing on Twitter - Part 2

<br />


## Series Parts: 
- [Part 1](/data-science/pandas/python/nltk/tweepy/2019/05/13/natural-language-processing-on-twitter-part-1.html)  
- [Part 2](/data-science/pandas/python/nltk/tweepy/2019/05/22/natural-language-processing-on-twitter-part-2.html)

<br />

## Importing data using Pandas

From our previous post, we exported our scraped data from twitter to `tweets.csv`. To be able to get meaningful information from our dataset, we must first convert it into something python can manipulate and understand. For this, we can use `pandas`[^1].

Pandas is a very powerful tool in and of itself and is widely used in data analysis and machine learning.

Before we can continue, let's begin by importing panda and reading the content of our csv file:

```python
import pandas as pd

tweets = pd.read_csv(
    'tweets.csv',
    names=[
        'created_at',
        'id',
        'text',
        'geo',
        'place',
        'lang',
        'retweet_count'])
```

The `read_csv` function converts the content of the file to a `data frame`[^2]. Check your data if it has been imported properly using `.head()` method.

```python
tweets.head()
```

<br />

## Getting started with Pandas

To get comfortable with pandas, let us first do a couple of problems. Suppose we want to get the days of the week for each tweet and count the number of tweets per day.

I need to first convert the `created_at` column to datetime then adjust it to local time by adding my timezone offset.

```python
gmt_offset = 9
tweets['time'] = pd.to_datetime(tweets['created_at'])
tweets['time'] = tweets.time + pd.to_timedelta(gmt_offset, unit='h')
```

From this, we can get the day equivalent of the time each tweet has been created by mapping it to a dictionary of all the days in a week.

```python
weekday_dict = {
    0: 'Mon',
    1: 'Tue',
    2: 'Wed',
    3: 'Thu',
    4: 'Fri',
    5: 'Sat',
    6: 'Sun'}
tweets['dow'] = [weekday_dict[t.dayofweek] for t in tweets.time]
```

To verify that the columns were successfully converted, let's print `tweets['dow`, `time`]`. We should have a result that looks something like:
```python
      dow                  time
0     Tue   2019-05-07 23:01:04
1     Tue   2019-05-07 22:54:53
2     Mon   2019-05-06 20:40:24
3     Sun   2019-05-05 19:39:51
4     Sat   2019-05-04 23:44:29
5     Sat   2019-05-04 23:44:01
...   ...                   ...
1442  Wed   2010-07-07 13:51:48
1443  Thu   2010-07-01 09:49:16
1444  Wed   2010-06-30 22:14:33
1445  Tue   2010-06-29 23:36:32
1446  Tue   2010-06-29 23:14:33

[1447 rows x 2 columns]
```

We can readily use this series, and to get the count of unique rows we can use the `value_counts()` method. 
```python
tweets['dow'].value_counts()
```

This will return a sorted list that looks something like this:
```python
Mon    248
Wed    244
Tue    241
Fri    203
Thu    197
Sat    160
Sun    154
Name: dow, dtype: int64
```

I have the highest tweet rate on monday at 248 while the lowest on sundays at 154. Similarly, we can get the language statistics for each tweet using `iso639`.
```python
from iso639 import languages

tweets['language'] = [languages.get(alpha2=l).name for l in tweets.lang]
```

Which returns something like this
```python
0          English
1          English
2          English
3          Tagalog
4          English
5          English
           ...
1442       English
1443       English
1444       English
1445       English
1446       English
Name: language, Length: 1447, dtype: object
```

Now, suppose we want to get the percentage of tweets by language. We can do this by first converting the result of `value_counts()` method to a new dataframe, else, python will report that the dataframes don't match.

Then, by using a generator, loop through `tweets_by_lang` and divide the value of each count column to the total number of tweets.

```python
total_tweets = len(tweets)
tweets_by_lang = tweets['language'].value_counts()
tweets_by_lang = tweets_by_lang.rename_axis(
    'language').reset_index(name='counts')

tweets_by_lang['percentage'] = [
    t / total_tweets * 100 for t in tweets_by_lang['counts']]
```

It should result into something like this:

```python
      language  counts  percentage
0      English     842   58.189357
1      Tagalog     529   36.558397
2   Indonesian      21    1.451279
3      Spanish       7    0.483760
4       German       5    0.345543
5     Estonian       5    0.345543
6       French       5    0.345543
7        Dutch       4    0.276434
8      Haitian       4    0.276434
9      Italian       4    0.276434
10     Latvian       3    0.207326
11      Polish       3    0.207326
12   Norwegian       3    0.207326
13       Welsh       2    0.138217
14      Danish       2    0.138217
15    Japanese       2    0.138217
16     Catalan       1    0.069109
17  Portuguese       1    0.069109
18  Lithuanian       1    0.069109
19      Basque       1    0.069109
20     Turkish       1    0.069109
21       Hindi       1    0.069109
```

<br />

## Notes:
[^1]: [Pandas](https://pandas.pydata.org/) is a suite of open-source, easy-to-use data structures and data analysis tools for python.
[^2]: A [data-frame](https://pandas.pydata.org/pandas-docs/version/0.23.4/generated/pandas.DataFrame.html) is a 2-dimensional size-mutable data structure with labeled axes (rows and columns)

