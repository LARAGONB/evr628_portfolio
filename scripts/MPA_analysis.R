################################################################################
# MPA Analaysis
################################################################################
#
# Lina Aragón
# linamaragonb@mgil.com
# September 18,2025
#
# Description
#
################################################################################  

#Load packages
pkgs <- c("EVR628tools", "tidyverse")
lapply(pkgs, library, character.only = T)
remove(pkgs)

#Load data
data_MPA <- EVR628tools::data_MPA

## Inspect the new ?data_MPA
?data_MPA

# 1. Load and inspect the new ?data_MPA
# 
# What are the dimensions of the data?

dim(data_MPA)
tibble(data_MPA)

# What are the column names?

colnames(data_MPA)

# How many unique() sites are there?

data_MPA$id |>
  unique() |> 
  length()

# How many unique() years?

data_MPA$time |> 
  unique() |> 
  length()

# Visualize the trends in biomass through time and across sites

ggplot(data = data_MPA,
       aes(x= time, y=biomass, col = id)) +
  geom_line(linewidth = 1)


ggplot(data = data_MPA,
       aes(x= time, y=biomass, col = protected == 1)) + #boolean for protected
  geom_point(aes(shape = after ==1),size = 3) +
  geom_smooth(method = "lm", se = F, linewidth = 1) +
  theme_bw()




# 2. Create four objects containing: 
# Hint: Use a combination of subsetting ([]), relational (==), and logical operators (&)

# Mean biomass inside the MPA before it was protected

mean_biom_in_before <- data_MPA$biomass[data_MPA$protected == 1 & data_MPA$after == 0] |> 
  mean()
mean_biom_in_before

mean_bion_in_before_2 <- data_MPA$biomass[which(data_MPA$protected == 1 & data_MPA$after == 0)] |> 
  mean()
mean_bion_in_before_2

# Mean biomass inside the MPA after it was protected


mean_biom_in_after <- data_MPA$biomass[which(data_MPA$protected == 1 & data_MPA$after == 1)] |> 
  mean()
mean_biom_in_after

# Mean biomass outside the MPA before the MPA was created

mean_biom_out_before <- data_MPA$biomass[which(data_MPA$protected == 0 & data_MPA$after == 0)] |> 
  mean()
mean_biom_out_before

# Mean biomass outside the MPA after the MPA was created

mean_biom_out_after <- data_MPA$biomass[which(data_MPA$protected == 0 & data_MPA$after == 1)] |> 
  mean()
mean_biom_out_after


# Then, calculate:
#   Change after vs before for the protected site

change_in <- mean_biom_in_after - mean_biom_in_before
change_in

#   Change after vs before for the unprotected site

change_out <- mean_biom_out_after - mean_biom_out_before
change_out

#   Finally, calculate the difference between these two sites
# This is called the naive difference-in-differences estimate. See Villasenor-Derbez et al. (2018) and Lynham and Villaseñor-Derbez (2024) for details.

naive_difference_in_differences <- change_in - change_out
naive_difference_in_differences

##Linear regression
#Differences in differences analysis
install.packages("fixest")
library(fixest)

feols(biomass ~ protected * after, data = data_MPA) |> 
  etable()

feols(biomass ~ i(protected, after) | id + time, data = data_MPA) |> 
  etable() # The | id + time part means we are controlling for site and year fixed effects
#i operator to interact factors with time





