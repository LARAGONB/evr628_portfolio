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

