################################################################################
# Code Style and Documentation
################################################################################
#
# Lina Aragón
# linamaragonb@mgil.com
# September 18,2025
#
# Description
#
################################################################################  

# Fix the style issues in this code:
#   
# mydataframe=data.frame(species=c("Great White","Tiger", "Bull"),
#                          length=c(4.5,3.2, NA))
# mean(mydataframe$length,na.rm=TRUE)
#   
# My improved code will be here

my_data_frame <- data.frame(
  species = c("Great White", "Tiger", "Bull"),
  length = c(4.5, 3.2, NA)
)

mean(my_data_frame$length, na.rm = TRUE)

#   Note: What’s with than na.rm = TRUE?