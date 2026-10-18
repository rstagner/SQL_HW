#Load libraries
library(tidyverse)
library(DBI)
library(duckdb)

# Download the DuckDB file from the provided URL
url <- "https://data-science-master.github.io/lectures/data/flights.duckdb"

download.file(url, destfile = "flights.duckdb", mode = "wb")

#create the connection and help translate between R and the database
conn <- dbConnect(duckdb(), "flights.duckdb", read_only = TRUE)

dbIsValid(conn) #check the connection

#Part 1a - List the first 10 rows of the flights table
dbGetQuery(conn, 
           "SELECT * --get all columns
           FROM flights --from the flights table
           LIMIT 10 --first 10 rows"
           )

#Part 1b - first, find the number of flights in the dataset

count_flights <- "SELECT COUNT(*) --counts the number of rows
                  FROM flights --in the flights table" 

dbGetQuery(conn, count_flights) #returns the result

#Part 1b - second find the number of flights by carrier

carrier_flights <- "SELECT carrier, --select the carrier column
                    COUNT(*) --count the number of rows
                    FROM flights --in the flights table
                    GROUP BY carrier --grouped by carrier"

dbGetQuery(conn, carrier_flights) #returns the result

#Part 1c - Find the average departure delay

dep_delay <- "SELECT AVG(dep_delay) AS dep_delay  --select the dep_delay column and find the mean
              FROM flights -- from the flights table"

dbGetQuery(conn, dep_delay) #returns the result 

