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

remotes::install_github("jcvdav/EVR628tools", force = T)
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
    
# 4.  Build time series with overlapping thresholds
library(tidyverse)
library(EVR628tools)


data("data_mhw_ts")
?data_mhw_events

ggplot(data_mhw_ts, 
       aes(x = date, y = temp)) +
  geom_line(aes(y = seas), color = "blue") +
  geom_line(aes(y = thresh), color = "red", show.legend = TRUE) +
  geom_line() +
  labs(x = "Date",
       y = "Temperature (°C)") +
  theme_bw(base_size = 14) +
  theme(
    axis.text = element_text(color = "black")
  )



#Loliplot


data("data_mhw_events")
ggplot(data_mhw_events,
       aes(x = date_peak,
           y = intensity_max, color = intensity_cumulative)) +
  geom_point(aes(y = intensity_max)) +
  geom_linerange(aes(ymin = 0,
                     ymax = intensity_max)) +
  scale_color_gradient(low = "grey90", high = "red") +
  labs(y = "MHW Intensity (°C)",
       x = "Date peak",
       color = "MHW cum. intensity (°C days)") +
  theme_bw(base_size = 14) +
  theme(
    axis.text = element_text(color = "black"),
    legend.title.position = "top",
    legend.position = "bottom",
    legend.key.width = unit(1.5, units = "cm")
  )




       