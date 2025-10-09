# .........................................
# Projet : A Shiny App for functional enrichment analysis
# Author : Mehdi Tachekort
# email  mehdi.tachekort@univ-rouen.com
# Affiliation : Université de Rouen Normandie
# Date : 08/10/2025
# Description : Application to perform functional enrichment analysis
# .........................................

library(styler)
library(shiny)
library(shinydashboard)
library(bs4Dash)
library(shinycssloaders)
library(waiter)


ui <- dashboardPage(
  dashboardHeader(title = "Enrichment Analeasy"),
  dashboardSidebar(
    # Home button
    sidebarMenu(
      id = "menu_home",
      menuItem("Home", tabName = "home", icon = icon("home"))
    ),

    # Download file button
    fileInput("file_upload", "Load a .csv file :",
      accept = c(".csv")
    ),

    # Select menu
    selectInput("fonction_select", "Select an organism name :",
      choices = c("Homo sapiens", "Canis lupus", "Mus musculus")
    ),


    # Navigation bar
    sidebarMenu(
      id = "menu_navigation",
      menuItem("Whole Data Expectation", tabName = "dataExpectation", icon = icon("chart-simple")),
      menuItem("GO Term Enrichment", tabName = "goEnrichment", icon = icon("magnifying-glass-chart")),
      menuItem("Pathway Enrichment", tabName = "pathwayEnrichment", icon = icon("database")),
      menuItem("About", tabName = "about", icon = icon("th"))
    )
  ),
  dashboardBody(
    # Add of the waiter
    use_waiter(),
    waiter_show_on_load(
      html = spin_fading_circles(),
      color = "#009688"
    ),
    
    # Tag to generate css for sideBar section
    # !important command to force new css attribute
    tags$head(
      tags$style(HTML("
      /*  Change the title */
      .brand-link {
      font-size : 24px !important; font-weight : bold !important; background-color : #009688 !important; width : 100% !important; text-align : center !important;
      }


      /* change the width of the main sideBar */
      .main-sidebar {
        width: 300px !important;  /* Largeur par défaut : 230px */
      }


      /* Adjust the principal content */
      .content-wrapper,
      .main-header .navbar {
        margin-left: 300px !important;  /* Doit être = largeur sidebar */
      }


      /* sideBar gestion when it's reduce (collapsed) */
      
      .sidebar-collapse .main-sidebar {
        width: 10px !important;
      }
      .sidebar-collapse .content-wrapper,
      .sidebar-collapse .main-header .navbar {
        margin-left: 50px !important;
      }

      /* navigation style */
      .nav {
      background-color : #009688 !important; padding:10px !important; border-radius:10px !important;
      }

       /* Style bs4Dash - for active link in navbar */
      .nav-sidebar .nav-item > .nav-link.active,
      .nav-sidebar .nav-item.menu-open > .nav-link {
        background-color: #4BA0B5 !important;
        color: white !important;
        font-weight: 600 !important;
      }
      
      /* style and animation of the navbar hover */
      .sidebar-menu > li > a:hover {
        background-color: #4BA0B5 !important;
        color: white !important;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); /* animation */
        transform: translateX(5px); /* animation */
      }
    ")),
    ),


    # Title of the page
    div(
      style = "width: 100%; display: flex; justify-content: center; align-items: center; padding: 10px 10px 20px 10px;",
      h1("Welcome on Enrichment Analeasy", style = "font-weight: bold; font-size: 32px; font-family: Arial, sans-serif; padding : 0, margin : 10px", )
    ),
    tabItems(
      # Page Home - Welcome and instructions to use the app
      tabItem(
        tabName = "home",
        h2("Welcome on Enrichment Analeasy, an application that will help you to achieve your functional enrichment analysis !",
          style = "padding:30px"
        ),
        box(
          style = "background-color : #009688",
          status = "info",
          solidHeader = TRUE,
          title = "Instructions :",
          p("1 - Load your data table", style = "font-weight: bold; font-size : 22px"),
          p("2 - Choose the log2FC with the slider", style = "font-weight: bold;font-size : 22px"),
          p("3 - Download your plot !", style = "font-weight: bold; font-size : 22px")
        )
      ),
      # Two bloc to generate plots
      tabItem(
        tabName = "dataExpectation",
        div(
          fluidRow(
            box(
              title = "",
              height = "175px",
              width = 6,
              status = "info",
              solidHeader = TRUE,
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
          # The slider to adjust the log2foldchange
          div(
            style = "width: 45%;",
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

          # A button to download the plot
          div(
            actionButton("download_btn", "Download",
              icon = icon("download"),
              width = "100%",
              style = "margin-top: 25px;"
            )
          )
        ),
        # bloc to receive the downloaded .csv
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

      # Page Go Enrichment - work in progress
      tabItem(
        tabName = "goEnrichment",
        h2("Work in progress..")
      ),

      # Page Pathway enrichment - work in progress
      tabItem(
        tabName = "pathwayEnrichment",
        h2("Work in progress..")
      ),

      # Page About - project presentation
      tabItem(
        tabName = "about",
        style = "padding:20px;",
        h2("Hi ! I'm Mehdi Tachekort. I developed this app as a part of a course on RShiny and functional enrichment analysis", style = "font-weight:bold"),
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
