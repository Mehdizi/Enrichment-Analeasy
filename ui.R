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
      menuItem("Whole Data Expectation", tabName = "dataExpectation", icon = icon("th")),
      menuItem("GO Term Enrichment", tabName = "goEnrichment", icon = icon("th")),
      menuItem("Pathway Enrichment", tabName = "pathwayEnrichment", icon = icon("th")),
      menuItem("About", tabName = "about", icon = icon("th"))
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
      
        /* Items non sélectionnés */
  .sidebar-menu > li > a {
    color: #E2E8F0 !important;
    padding: 14px 20px !important;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  
  /* Au survol */
  .sidebar-menu > li > a:hover {
    background-color: #2D3748 !important;
    color: white !important;
    transform: translateX(5px);
  }
      
       /* Style pour bs4Dash - Item actif */
  .nav-sidebar .nav-item > .nav-link.active,
  .nav-sidebar .nav-item.menu-open > .nav-link {
    background-color: #4BA0B5 !important;
    color: white !important;
    font-weight: 600 !important;
  }
      /* Style au survol */
      .sidebar-menu > li > a:hover {
        background-color: #4BA0B5 !important;
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
                  status = "info",
                  solidHeader = TRUE,
                  title = "Instructions :",
                  p("1 - Load your data table", style = "font-weight: bold; font-size : 22px" ),
                  p("2 - Choose the log2FC with the slider", style = "font-weight: bold;font-size : 22px"),
                  p("3 - Download your plot !", style = "font-weight: bold; font-size : 22px")
              )
      ),
      #Deux bloc l'un a coté de l'autre avec une parti bleu en haut du bloc
      tabItem(tabName = "dataExpectation",
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
      tabItem(tabName = "goEnrichment",
              h2("Work in progress..")
      ),
      
      # Page Item 3 - VIDE
      tabItem(tabName = "pathwayEnrichment",
              h2("Work in progress..")
      ),
      
      # Page Item 4 - VIDE
      tabItem(tabName = "about",
              style="padding:20px",
              h2("Hi ! I'm Mehdi Tachekort. I developed this app as a part of a course on RShiny and functional enrichment analysis", style="font-weight:bold"),
              p("I'm proud to show you my work. For now, I'v just developed the ui but the functionality will be there soon !"),
              p("If you want to see my codebase, you can click on the link below"),
              tags$a(
                href = "https://github.com/Mehdizi/Enrichment-Analeasy",
                target = "_blank",
                "Github"
              ),
      )
    )
  ),
)
