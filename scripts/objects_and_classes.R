################################################################################
# Playing with objects classes
################################################################################
#
# Lina Aragón
# linamaragonb@gmail.com
# date
#
# Description
#
################################################################################  

#Part A
# In your R Script, create objects of different classes and check their types:
#   
## A character object called my_name with your name
## A numeric object called my_age with your age (or any number, it doesn’t have to be your age)
## A logical object called is_student with TRUE or FALSE
## Check the class of each object using class()



my_name <- "Lina Aragón"
my_age <- 31
is_student <- T

class(my_name)
class(my_age)
class(is_student)


#Part B
# Let’s see what happens when you try converting objects. In the R script, write and then execute code that will:
#   
# Convert your age to character using as.character(my_age)
# Convert TRUE to numeric using as.numeric()
# Try to convert "hello" to numeric - what happens?
#   Advanced: Use |> to build a code pipeline to:
#   Take your age
#   Convert it to character
#   Get it’s class

as.character(my_age)
as.numeric(is_student)

as.numeric("Hello") #NA results

con <- my_age |>
  as.character() |>
  class()

con

colors <- c("red", "blue", "green", "orange", "yellow")

colors[!colors == "red"]


#Part C
# Clean you environment (use the broom icon)
# Create a numeric vector called length_m with values: 6, 4.1, 2.8, 5.5, 3.9, 5.8
# Create a character vector called shark_species with: Great White Shark, Lemon Shark, Bull Shark, Hammerhead Shark, Mako Shark, and Great White Shark (yes, white shark again)
# How many variables do you have in your environment?
# How many length observations do we have? Find the length of both vectors using length()
# How many unique species do we have? (Hint, use |> to build a pipeline)
# Calculate the mean length of all sharks using mean()
# Find the maximum length using max()

length_m <- c(6, 4.1, 2.8, 5.5, 3.9, 5.8)
shark_species <- c("Great White Shark", "Lemon Shark", "Bull Shark", 
                   "Hammerhead Shark", "Mako Shark", "Great White Shark")



length(environment())
length(length_m)
length(shark_species)

shark_species |> 
  unique() |> 
  length()

mean(length_m)
max(length_m)


# Part B: Vector Operations and Indexing
# 
# Extract the first 3 shark species using indexing with [] and save them to an object called first_3
# Extract shark species where maximum length is greater than 4 meters
# Assuming the values in length_m and sharks_species are ordered so that they match each other, find the shark species that is the largest
# Calculate the mean length for all great whites sharks

table1 <- tibble(shark_species,length_m)


first_3_o1 <- shark_species[1:3]; first_3_o1

first_3_o2 <- table1[1:3,]; first_3_o2

greater_4_o1 <- shark_species[length_m > 4]; greater_4_o1

greater_4_o2 <- table1$shark_species[table1$length_m > 4]; greater_4_o2


# max_shark_o1 <- shark_species[max(length_m)]; max_shark_o1 #This doesn't work beacause it is a coincidence

max_shark_o3 <- shark_species[length_m == max(length_m)]; max_shark_o3

min_shark_o3 <- shark_species[length_m == min(length_m)]; min_shark_o3

max_shark_o2 <- table1$shark_species[length_m == max(table1$length_m)]; max_shark_o2

mean_great <- length_m[shark_species == "Great White Shark"] |> 
  mean(); mean_great




