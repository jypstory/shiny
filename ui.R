

#install.packages("shinydashboard")
library(shiny)
library(shinydashboard)

header <- dashboardHeader(title = "My Dashboard",
                          titleWidth = 300,
                          dropdownMenu(type = "messages",
                                       messageItem(
                                         from = "Sales Dept",
                                         message = "Sales are steady this month."
                                       ),
                                       messageItem(
                                         from = "New User",
                                         message = "How do I register?",
                                         icon = icon("question"),
                                         time = "13:45"
                                       ),
                                       messageItem(
                                         from = "Support",
                                         message = "The new server is ready.",
                                         icon = icon("life-ring"),
                                         time = "2014-12-01"
                                       )
                          ),
                          dropdownMenu(type = "tasks", badgeStatus = "success",
                                       taskItem(value = 90, color = "green",
                                                "Documentation"
                                       ),
                                       taskItem(value = 17, color = "aqua",
                                                "Project X"
                                       ),
                                       taskItem(value = 75, color = "yellow",
                                                "Server deployment"
                                       ),
                                       taskItem(value = 80, color = "red",
                                                "Overall project"
                                       )
                          )
)

sidebar <- dashboardSidebar(
  width = 300,
  sidebarMenu(
    sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                      label = "Search..."),
    
    ## prefix : menu_skc_pore_
    menuItem("[SKC]Detect Pore", tabName = "menu_skc_pore_top", 
             icon = icon("dashboard"),
             menuItem('Training DL',
                      tabName = 'menu_skc_pore_training_dl',
                      icon = icon('line-chart')),
             
             ## prefix : menu_skc_pore_detect_
             menuItem('Detect Result',
                      tabName = 'menu_skc_pore_detect_result',
                      icon = icon('line-chart')
                      
             ),
             
             dateInput('menu_skc_pore_input_month',
                       label = paste('Search Month'),
                       value = as.character(Sys.Date()),
                       min = Sys.Date() - 100, max = Sys.Date() + 100,
                       format = "yy/mm",
                       startview = 'year', weekstart = 1
             ),
             actionButton(inputId = "menu_skc_pore_detect_btn", label = "Action", 
                          icon("paper-plane"), 
                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
             menuItem('Detect Result',
                      tabName = 'menu_skc_pore_detect_result_1',
                      icon = icon('line-chart'),
                      menuSubItem('l',
                                  tabName = 'l',
                                  icon = icon('line-chart')),
                      menuSubItem('m',
                                  tabName = 'm',
                                  icon = icon('line-chart')))
    ),
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Source code", icon = icon("file-code-o"), 
             href = "https://github.com/rstudio/shinydashboard/"),
    sidebarMenuOutput("menu"),
    menuItemOutput("menuitem")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "menu_skc_pore_training_dl",
            fluidRow(
              # A static infoBox
              infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
              # Dynamic infoBoxes
              infoBoxOutput("progressBox"),
              infoBoxOutput("approvalBox")
            ),
            
            # infoBoxes with fill=TRUE
            fluidRow(
              infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
              infoBoxOutput("progressBox2"),
              infoBoxOutput("approvalBox2")
            )
    ),
    
    tabItem(tabName = "menu_skc_pore_detect_result",
            h2("menu_skc_pore_detect_result"),
            hr(),
            imageOutput("menu_skc_pore_detect_image")
    )
  )
)

dashboardPage(header, sidebar, body)
