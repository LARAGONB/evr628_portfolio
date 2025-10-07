################################################################################
# Create a new graph
################################################################################
#
# Lina Aragón Baqiero
# linamaragonb@gmail.com
# October 7, 2025
#
# Description
#
################################################################################  

# 1. Load packages ----
library(tidyverse)
library(EVR628tools)

# 2. Load data ----
data("data_lionfish")

# 3. Plot lionfish data ----
ggplot(data_lionfish,
       aes(x = total_length_mm,
           y = total_weight_gr)) +
  geom_vline(xintercept = c(100,200), linetype = "dashed") +
  geom_smooth(color = "black", linetype = 2) +
  geom_point(aes(color = size_class), size = 3) +
  scale_color_manual(values = palette_UM(n = 3)) +
  labs(x = " Total length (mm)",
       y = "Total weight (gr)",
       color = "Size class") +
  theme_bw(base_size = 16) +
  theme(
    axis.text = element_text(color = "black"),
    axis.ticks = element_line(color = "black"),
    legend.background = element_rect(fill = "transparent"),
    legend.position = "inside",
    legend.position.inside = c(0,1),
    legend.justification.inside = c(0,1),
  )
    
