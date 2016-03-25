library(shiny)

# Define UI for our height prediction application
shinyUI(fluidPage(
  
  #   Application title
 
  titlePanel ("Application to predict height of a child !"),
  tags$img(src = "https://raw.githubusercontent.com/BijoySasidharan/height_prediction_app/master/menace_height.jpg",width = "200px", height = "300px"),
  tags$br(), 
  # Sidebar with a couple of numeric inputs and a radio button
  sidebarLayout(
    sidebarPanel(
      HTML('<style type="text/css">
     .row-fluid .span4{width: 26%;}
           </style>'),
      
      helpText("Are you curious to know how tall your kid will grow once he/she reaches their prime age ?
      This app wil help predict it!
      "),
      tags$code("A prediction model built using Galton's scientific data is used in this app."),
      helpText("Select the required input values from the options given below:"),
      tags$br(),     
      sliderInput(inputId = "inFh",
                  label = "Father's height in inches :",
                  value = 70, # average height of fathers
                  min = 62,
                  max = 78,
                  step = .5),

       
      sliderInput(inputId = "inMh",
                   label = "Mother's height in inches :",
                   value = 64, # average height of mothers
                   min = 58,
                   max = 70,
                   step = .5),
      radioButtons(inputId = "inGen",
                   label = "Child's gender: ",
                   choices = c("Male"="male","Female"="female"),
                   inline = TRUE)
      ),
    
    
    # Show text indicating the values entered
    mainPanel(
      htmlOutput("prediction"),
      plotOutput("barsPlot", width = "100%")

    ))

 ))