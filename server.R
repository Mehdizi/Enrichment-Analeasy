# .........................................
# Projet : A Shiny App for functional enrichment analysis
# Author : Mehdi Tachekort
# email  mehdi.tachekort@univ-rouen.com
# Affiliation : Université de Rouen Normandie
# Date : 08/10/2025
# Description : Application to perform functional enrichment analysis
# .........................................

library(shiny)
library(bslib)
library(tidyverse)
library(reactable)


server <- function(input, output) {
  
  # Time of sleep simulation
  Sys.sleep(0.3)  # 0.3 secondes
  
  # hide the waiter after
  waiter_hide()

#===============================================================================
#INPUT PART
#===============================================================================
  
  #Load data
  data <- reactive({
    #document upload verification 
    req(input$file_upload)
    #save the path of loaded data
    file_path <- input$file_upload$datapath
    #Read the file
    dt <- read.csv(file_path, sep=";")
    #return data
    return(dt)
  })
  
#===============================================================================
#OUTPUT PART
#===============================================================================

  
  #==========================================================================
  # VOLCANOPLOT
  #==========================================================================
  output$volcanoplot <- renderPlot({
    
    
    pvalue_seuil <- 1
    foldchange_seuil <- input$foldChangeSlider
    
    data_plot <- data()
    
    #Comptage des points qui sont sous et sur régulé
    count_inf <- sum(-log10(as.numeric(data_plot$p_value)) > -log10(pvalue_seuil) & 
                       data_plot$log2FC > foldchange_seuil)
    
    count_sup <- sum(-log10(as.numeric(data_plot$p_value)) > -log10(pvalue_seuil) & 
                       data_plot$log2FC < -foldchange_seuil)
    
    significative_points <- count_sup + count_inf
  
    colors <- ifelse (
      -log10(data_plot$p_value) > -log10(pvalue_seuil) & 
        (data_plot$log2FC > foldchange_seuil),
      "red",
      ifelse(
        -log10(data_plot$p_value) > -log10(pvalue_seuil) & data_plot$log2FC < -foldchange_seuil,
        "blue",   # Down-régulé
        "grey"    # Non significatif
      )
    )
    
    #Compter les points a l'extérieur et rendre la valeur du texte dynamique
    
    plot(data_plot$log2FC, -log10(as.numeric(data_plot$p_value)),
         xlab = "Log2FC",
         ylab ="-log10(pvalue)",
         main="Volcano plot",
         col = colors,
         pch=20
    )
    
    abline(v = c(-input$foldChangeSlider, input$foldChangeSlider), col = "blue", lty = 2, lwd = 2)
  })
  #==========================================================================
  # TABLE
  #==========================================================================
  
  output$dataTable <- renderReactable({
    data_table <- data()

    reactable(
      data(),
      searchable = TRUE,
      filterable = TRUE,
      striped = TRUE,
      highlight = TRUE,
      defaultPageSize = 10
    )
  })
  
}