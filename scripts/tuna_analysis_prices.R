################################################################################
# Tyding price data
################################################################################
#
# Lina Marcela Aragón Baquero
# linamaragonb@gmail.com
# October 2nd, 2025
#
# Description
#
################################################################################  

# PART1 ----

## 1. Install and load packages ----

install.packages("readxl")
library(readxl)
library(tidyverse)
library(janitor)

## 2. Load data ----

# Define the old and new paths for the directory
old_dir_path <- "data/raw/Economic-and-Development-Indicators-and-Statistics-Tuna-Fishery-of-the-Western-and-Central-Pacific-Ocean-2024-32765"
new_dir_path <- "data/raw/fishery"

# Rename the directory
file.rename(from = old_dir_path, to = new_dir_path)

# Load data

tidy_tuna_prices <- as_tibble(read_excel("data/raw/fishery/Compendium of Economic and Development Statistics 2024.xlsx",
                   sheet = "B. Prices",
                   range = "A35:E63",
                   na = "na")) |> 
  clean_names()

## 3. Inspect ----
# Inspect the column names of tuna_prices using colnames() in your console.
colnames(tidy_tuna_prices)

# How many columns and rows do we have?
dim(tidy_tuna_prices)

# Any missing values?

glimpse(tidy_tuna_prices)

tidy_tuna_prices |> 
  filter_all(any_vars(is.na(.)))

# Do we need to make the data wider or longer?
longer

# Using comments, write out what the target data should be (expand my code chunk see what I wrote)

#The data set has 5 columns, we want to make it longer by keeping year as it is and transforming 
#japan_fresha, japabn_frozenb, us_freshc, and us_frozend to three cols:
#that will be market, presentation, and price

## 4. Tidy data ----

# Look at the documentation for your pivot_* function. What does it say about cases where names_to is of length > 1?
# What about the names_sep argument?
# Use the appropriate pivot_* function to reshape your data and save them to a new object called tidy_tuna_prices3
# Your resulting tibble should have 104 rows and 4 columns and look like this:4

tidy_tuna_prices3 <- tidy_tuna_prices |> 
  pivot_longer(
    cols = !year,
    names_to = c("country", "type"),
    names_sep = "_",
    values_to = "price",
    values_drop_na = T
  ) |> 
  mutate(
    type = case_when(
      type %in% c("fresha","freshc") ~ "fresh",
      type %in% c("frozenb", "frozend") ~ "frozen",
    )
  )

#Modify the pipeline that creates tidy_tuna_prices to get the mean price per year5

tidy_tuna_prices3 <- tidy_tuna_prices |> 
  pivot_longer(
    cols = !year,
    names_to = c("country", "type"),
    names_sep = "_",
    values_to = "price",
    values_drop_na = T
  ) |> 
  mutate(
    type = case_when(
      type %in% c("fresha","freshc") ~ "fresh",
      type %in% c("frozenb", "frozend") ~ "frozen",
    )
  ) |> 
  group_by(year) |> 
  summarise(mean_price = mean(price))



# PART 2 ----

## 1. Load data ----
data_catch <- read_csv("data/raw/CatchByFlagGear/CatchByFlagGear1918-2023.csv")
head(data_catch)

## 2. Rename columns ----
data_catch_clean <-data_catch |> 
  janitor::clean_names() |> 
  rename(
    year = ano_year,
    flag = bandera_flag,
    gear = arte_gear,
    species = especies_species,
    catch = t
  )

data_catch_clean

## 3. Calculate total catch by year.

sum_catch <-data_catch |> 
  janitor::clean_names() |> 
  rename(
    year = ano_year,
    flag = bandera_flag,
    gear = arte_gear,
    species = especies_species,
    catch = t
  ) |> 
  filter(
    species == "BET",
    gear == "PS",
    year >= 2000,
  ) |> 
  group_by(year) |> 
  summarise(
    sum_catch = sum(catch)
  )

# PART 3 ----

# Think about what type of join you want -- Left join
# What will be on the left and what will be on the right? --- Catch data in the left and Price data in the right
# What is the key? --- Year
# Write down, using human language, what you want to do.--- I will join the two tables using left_join

## Calculate tuna revenues ----

tuna_revenues <- left_join(
  sum_catch, tidy_tuna_prices3, by = join_by(year)) |> 
  mutate(
    revenue = (sum_catch * mean_price)/1000000 
  )

# PART 4 ----

## Total revenue since 2000 ----

total_revenue <- sum(tuna_revenues$revenue)

## Mean ANNUAL revenue since 2000 ----

mean_annual_rev <- mean(tuna_revenues$revenue)

## Make a figure ----

ggplot(tuna_revenues, aes(x = year, y = revenue)) + 
  geom_point() +
  geom_line(lineend = "square", linetype = 2, arrow = arrow()) +
  labs(
    x = "Year",
    y = "Revenue (M USD)"
  ) +
  theme_bw()

