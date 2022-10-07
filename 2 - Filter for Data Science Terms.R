## This part of the script assumes Option 3b in the first part. 
## Amend new_faves to faves if running for the first time

#4 TWEET TEXT TO LOWER CASE LOWER CASE 
new_faves$lower_text <- tolower(new_faves$full_text)

#5 CREATE LIST OF KEY WORDS TO FILTER - I am using Data Science terms. 
words_to_keep <- c("rstats", " r ", "rstudio", "tidyverse", 
                   "python", "sql", "excel ", 
                   "tableau", "power bi",
                   "nlp", "machine learning", 
                   "shiny", "data vi", "cloud", 
                   "data mining", "datamining", "web3", 
                   "crypto", "blockchain", "deeplearning", 
                   "neural", "neuralnetwork", "statistics",
                   "artificial", "artificial intelligence", "tensor")
#..THEN FILTER
new_faves <- new_faves %>%
  filter(str_detect(lower_text, str_c(words_to_keep, collapse = '|'))) #601 Tweets

#6 CREATE HYPERLINKS
#URL pattern
url_pattern <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
#Filter for URLs 
new_faves$content_url <- str_extract(new_faves$full_text, url_pattern)
new_faves <- new_faves %>%
  filter(nchar(content_url) > 0)
#Make URLs external links that open in a new window.
new_faves$url <- paste0("<a href='", new_faves$content_url,"' target='_blank'>","LINK","</a>")
#494 Tweets

#7 WRITE OUT
faves <- rbind(faves, new_faves) #Remove this line if running for first time
#Clear enviroment
rm(new_faves, twitter_token, access_secret, access_token, appname,
   key, last_tweet, secret, url_pattern, username, words_to_keep)

write_rds(faves, 'faves.rds')