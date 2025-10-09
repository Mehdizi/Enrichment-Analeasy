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
    fileInput("file_upload", "Load a .csv file :",
      accept = c(".csv")
      ),
    
    #Le menu déroulant
    selectInput("fonction_select", "Select an organism name :",
      choices = c("Homo sapiens", "Canis lupus", "Mus musculus")
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
    #Gère le css de la partie SideBar qui ne peut pas être géré sur l'élément lui même mais que à travers le body
    tags$head(
      tags$style(HTML("
      /*  Change le titre en haut à gauche */
      .brand-link {
      font-size : 24px !important; font-weight : bold !important; background-color : #009688 !important; width : 100% !important; text-align : center !important;
      }
      /* Changer la largeur de la sidebar */
      .main-sidebar {
        width: 300px !important;  /* Largeur par défaut : 230px */
      }
      /* Ajuster le contenu principal pour compenser */
      .content-wrapper,
      .main-header .navbar {
        margin-left: 300px !important;  /* Doit être = largeur sidebar */
      }
      /* Quand la sidebar est réduite (collapsed) */
      .sidebar-collapse .main-sidebar {
        width: 10px !important;
      }
      .sidebar-collapse .content-wrapper,
      .sidebar-collapse .main-header .navbar {
        margin-left: 50px !important;
      }
      
      /* Change la couleur de la navbar */
      .nav {
      background-color : #009688 !important; padding:10px !important; border-radius:10px !important;
      }
      
      /* Style quand un menuItem est ACTIF/SÉLECTIONNÉ */
      .sidebar-menu > li.active > a {
        background-color: #5C6BC0 !important;  /* Ta couleur */
        color: white !important;
        border-left: 4px solid #3F51B5 !important;
        font-weight: 600 !important;
      }
      
      /* Style au survol */
      .sidebar-menu > li > a:hover {
        background-color: #4A5568 !important;
        color: white !important;
      }
    ")
  ),
    ),
    
    
    #Titre centré
    div(
      style = "width: 100%; display: flex; justify-content: center; align-items: center; padding: 10px 10px 20px 10px;",
      h1("Welcome on Enrichment Analeasy", style = "font-weight: bold; font-size: 32px; font-family: Arial, sans-serif; padding : 0, margin : 10px",)
    ),
    tabItems(
      # Page Home - VIDE
      tabItem(tabName = "home",
              h2("Welcome on Enrichment Analeasy, an application that will help you to achieve your functional enrichment analysis !",
                 style= "padding:30px"),
              box(style = "background-color : #009688",
                  title = "Instruction :",
                  p("1 - Load your data table", style = "font-weight: bold; font-size : 22px" ),
                  p("2 - Choose the log2FC with the slider", style = "font-weight: bold;font-size : 22px"),
                  p("3 - Download your plot !", style = "font-weight: bold; font-size : 22px")
              )
      ),
      #Deux bloc l'un a coté de l'autre avec une parti bleu en haut du bloc
      tabItem(tabName = "item1",
              div (
                fluidRow(
                  box(
                    title = "",
                    height = "175px",
                    width = 6,
                    status = "info",      # Couleur : primary, success, warning, danger, info
                    solidHeader = TRUE,      # Active la coloration du header
                    plotOutput("", height = "150px")
                  ),
                  box(
                    status = "info",
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
            status = "info",
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
