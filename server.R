library(shiny)
library(bslib)
library(tidyverse)

server <- function(input, output) {
  
  # Simulation of the time of sleep
  Sys.sleep(1.5)  # 1.5 secondes
  
  # hide the waiter after
  waiter_hide()
}