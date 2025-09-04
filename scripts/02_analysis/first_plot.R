library(usethis)
usethis::git_vaccinate()
create_dirs()

#Build a simple graph
#Load packages
pkgs <- c("ggplot2","EVR628tools")
lapply(pkgs, library, character.only = T)
remove(pkgs)

#Load data
data("data_lionfish")




#Build a plot

p <- ggplot(data = data_lionfish,
            mapping = aes(x=size_class, y=total_length_mm)) +
  geom_boxplot()
p

#Export my plot

ggsave(plot = p,
       filename = "results/img/my_first_plot.png")


