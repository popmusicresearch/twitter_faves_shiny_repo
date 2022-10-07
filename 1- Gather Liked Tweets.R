#1 INSTALL PACKAGES
library(rtweet)
library(tidyverse)
library(tm)
library(stringr)
library(dplyr)

#2: AUTHENTICATE APP
appname <- "YOUR_APP_NAME"
## api key (example below is not a real key)
key <- "XXXXXXXXXXXXXXXXXXXXXX"
## api secret (example below is not a real key)
secret <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
## access token (example below is not a real key)
access_token <- 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
## access secret (example below is not a real key)
access_secret <- 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)

username <- "XXXXXX" # Your Twitter Username goes here

## If running for the first time: 

#3a
faves <- get_favorites(username, 3000) #2961 Tweets

## If updating previous version

#3b
faves <- readRDS('faves.rds') # Read in previously gathered favourites
last_tweet <- as.character(max(faves$id))
new_faves <- get_favorites(username, 3000, since_id = last_tweet)

