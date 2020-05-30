---
title: "Natural Language Processing on Twitter - Part 1"
date: 2019-05-13 18:12:28 +08:00
modified: 2019-05-13 18:12:28 +08:00
tags: [data-science, pandas, python, nltk, tweepy]
description:
series:
archived: true
---

# Natural Language Processing on Twitter - Part 1

<br />


## Series Parts: 
- [Part 1](/data-science/pandas/python/nltk/tweepy/2019/05/13/natural-language-processing-on-twitter-part-1.html)  
- [Part 2](/data-science/pandas/python/nltk/tweepy/2019/05/22/natural-language-processing-on-twitter-part-2.html)

<br />

## What is __*Natural Language Processing*__ or __*NLP*__?

Natural language processing, as defined by [wikipedia](https://en.wikipedia.org/wiki/Natural_language_processing) is a branch of computer science dealing with human-computer interactions, specifically, through the use of natural language. It uses artificial intelligence, information engineering as well as machine learning to process and analyze natural language datasets.

<br />

## Pre-requisites

Before we can fetch data from twitter, let us first authorize our app by providing consumer and access tokens. These can be generated [here](http://apps.twitter.com).
```python
import tweepy

# Setup authentication via tokens
access_token = 'xxxx'
access_token_secret = 'xxxx'
consumer_key = 'xxxx'
consumer_secret = 'xxx'
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

# Generate tweet API object
api = tweepy.API(auth)
```

Using the `api`, we can get various objects like user, tweets, location, etc. Full documentation can be found [here](http://docs.tweepy.org/en/latest/api.html)

<br />

## Scraping Twitter for our dataset

What we are after though are tweets, in this case, my personal tweets. We can fetch this by using the `user_timeline()` method. If no user is specified, it will return the latest tweets by the authenticated.
```python
my_tweets = api.user_timeline()
```

By default, it fetches the latest 20 tweets at a time which can be increased by providing a `count` argument which also max out at 200 per page. In the same way, we can navigate through the timeline by passing a `page` or `since_id`,`max_id` arguments.
```python
my_tweets = api.user_timeline(count=42, page=2)
my_tweets = api.user_timeline(since_id=123, max_id=456)
```

We begin by declaring a variable to house all the tweets, which we will populate with a preliminary pull from the timeline. We need this step to have an id we can use as a reference for the `max_id` argument to avoid duplicates.
```python
tweets = []
my_tweets = api.user_timeline(count=200)
tweets.extend(my_tweets)
oldest = tweets[-1].id - 1
```

Then, until there are no more tweets left to be fetch, do the request.
```python
tweets = []
my_tweets = []
oldest = None

# Iterate over all tweets until there are no more
while len(my_tweets) > 0 or not oldest:
    my_tweets = api.user_timeline(count=200, max_id=oldest)
    tweets.extend(my_tweets)
    oldest = tweets[-1].id - 1
```

<br />

## Persisting data for later use

After successfully pulling all tweets, we can now write it to a csv file for later consumption.
```python
import csv

with open('tweets.csv', 'w', newline='') as myfile:
    for tweet in tweets:
        wr = csv.writer(myfile, quoting=csv.QUOTE_ALL)
        wr.writerow([
            tweet.created_at,
            tweet.id,
            tweet.text,
            tweet.geo,
            tweet.place,
            tweet.lang,
            tweet.retweet_count
        ])
```

Putting it all together
```python
import tweepy
import csv

# Setup authentication via tokens
access_token = 'xxxx'
access_token_secret = 'xxxx'
consumer_key = 'xxxx'
consumer_secret = 'xxx'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

# Generate tweet API object
api = tweepy.API(auth)

tweets = []
my_tweets = []
oldest = None

# Iterate over all tweets until there are no more
while len(my_tweets) > 0 or not oldest:
    my_tweets = api.user_timeline(count=200, max_id=oldest)
    tweets.extend(my_tweets)
    oldest = tweets[-1].id - 1

# Write tweets to csv
with open('tweets.csv', 'w', newline='') as myfile:
    for tweet in tweets:
        wr = csv.writer(myfile, quoting=csv.QUOTE_ALL)
        wr.writerow([
            tweet.created_at,
            tweet.id,
            tweet.text,
            tweet.geo,
            tweet.place,
            tweet.lang,
            tweet.retweet_count
        ])
```

In the next part, we will take a look at basic dataset analysis using pandas.
