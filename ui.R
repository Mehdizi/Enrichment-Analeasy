#.........................................
#Projet : A Shiny App for functional enrichment analysis 
#Author : Mehdi Tachekort 
#Affiliation : Université de Rouen Normandie 
#Date : 08/10/2025
#Description : Application d'analyse d'enrichissement fonctionnel  
#usage : 
#.........................................

library(shiny)
library(shinydashboard)
library(bs4Dash)

ui <- dashboardPage(
  dashboardHeader(title = "Enrichment Analeasy"),
  
  dashboardSidebar(
    #Le bouton Home
    sidebarMenu(
      id = "menu_home",
      menuItem("Home", tabName = "home", icon = icon("home"))
    ),
    
    #Le bouton pour charger un fichier
    fileInput("file_upload", "Charger un fichier",
      accept = c(".csv")
      ),
    
    #Le menu déroulant
    selectInput("fonction_select", "Sélectionner une fonction",
      choices = c("Fonction 1", "Fonction 2", "Fonction 3")
      ),
    
    
    #La liste des 4 items
    sidebarMenu(
      id = "menu_navigation",
      menuItem("item1", tabName = "item1", icon = icon("th")),
      menuItem("item2", tabName = "item2", icon = icon("th")),
      menuItem("item3", tabName = "item3", icon = icon("th")),
      menuItem("item4", tabName = "item4", icon = icon("th"))
    )
  ),
  
  dashboardBody(
    #Titre centré
    div(
      style = "width: 100%; display: flex; justify-content: center; align-items: center; padding: 10px 10px 20px 10px;",
      h1("Welcome to my Shiny Application", style = "font-weight: bold; font-size: 32px; font-family: Arial, sans-serif; padding : 0, margin : 10px",)
    ),
    
    tabItems(
      
      # Page Home - VIDE
      tabItem(tabName = "home",
              h2("Page d'accueil")
      ),
      #Deux bloc l'un a coté de l'autre avec une parti bleu en haut du bloc
      tabItem(tabName = "item1",
              div (
                fluidRow(
                  box(
                    title = "",
                    height = "175px",
                    width = 6,
                    status = "primary",      # Couleur : primary, success, warning, danger, info
                    solidHeader = TRUE,      # Active la coloration du header
                    plotOutput("", height = "150px")
                  ),
                  box(
                    status = "primary",
                    solidHeader = TRUE,
                    title = "",
                    height = "175px",
                    width = 6,
                    plotOutput("", height = "150px")
                  )
                ),
              ),
        
        fluidRow(
          style = "display: flex; justify-content: space-between; margin: 0 20px;",
          #un slider 
          div(
            style = "width: 45%;",  # Le slider prend 45% de l'espace
            sliderInput(
              inputId = "slider",
              label = "Slider",
              min = 0,
              max = 50,
              value = 25,
              step = 1,
              width = "100%"
            )
          ),
          #Un bouton download pour télécharger le plot
          div(
            style = "",  # Le bouton prend 30% de l'espace
            actionButton("download_btn", "Download", 
                         icon = icon("download"),
                         width = "100%",
                         style = "margin-top: 25px;")
          )
        ),
        #un bloc servant a recevoir un tableau de donnée 
        fluidRow(
          box(
            status = "primary",
            solidHeader = TRUE,
            title = "",
            width = 12,
            height = "200px",
            plotOutput("", height = "150px")
          ),
        )
      ),
      tabItem(tabName = "item2",
              h2("Item 2")
      ),
      
      # Page Item 3 - VIDE
      tabItem(tabName = "item3",
              h2("Item 3")
      ),
      
      # Page Item 4 - VIDE
      tabItem(tabName = "item4",
              h2("Item 4")
      )
    )
  ),
)
