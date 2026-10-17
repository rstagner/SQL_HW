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
           "SELECT *
           FROM flights
           LIMIT 10")
