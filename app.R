# Loading the libraries we need for this assignment
library(shiny)
library(tidyverse)
library(bslib)
library(thematic)
library(plotly)
library(DT)
library(ggmosaic)



# The darkly theme along with filter bars is obtained from garrett gmann who works for posit cloud : https://github.com/garrettgman/shiny-styling-demo/blob/main/finished-app/app.R
ggplot2::theme_set(ggplot2::theme_minimal())
thematic_shiny()

#Defining the UI theme provided by Garrett gman
ui <- navbarPage(
  title = "Digitalis Investigation Group (DIG) Trial",
  theme = bs_theme(bootswatch = "darkly",
                   base_font = font_google("Lato"),
                   heading_font = font_google("Raleway")),
  
  
  #Adding multiple panels to the shiny page : https://www.youtube.com/watch?v=V8ne6_F7lIM
  
  
  
  #Introduction Tab to the DIG trial
  
  tabPanel("Introduction to the DIG Trial", fluidPage(tags$head( tags$style(HTML("

.about-page {background-image: url('https://www.ucsfhealth.org/-/media/project/ucsf/ucsf-health/medical-tests/hero/digoxin-test-2x.jpg?rev=ae7227c07f7e4a338f1df1628fbcee89');background-size: cover;

background-position: center;

text-align: center;

color: white;

padding: 50px;}

 

.about-header { display: flex;justify-content: center;align-items: center;gap: 20px;}

.about-header img { width: 70px;height: 70px;border-radius: 50%;border: 3px solid white;object-fit: cover;}

.intro-box {background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */color: white;padding: 20px;margin: 20px 0;border-radius: 10px; text-align: left;}

.image-container { display: flex;justify-content: center;align-items: center;gap: 20px;}

.circle-image { width: 350px;height: 350px;object-fit: cover;border-radius: 50%;}"))),
                                                      
                                                      
                                                      div( 
                                                        class = "about-page",
                                                        div(
                                                          class = "about-header",
                                                          img(src = "https://media.giphy.com/media/ToMjGpAibV4AwKryEXS/giphy.gif"),
                                                          h1("Introduction to the Digitalis Investigation Group (DIG) Trial"),
                                                          img(src = "https://media.giphy.com/media/l3YSj6Oirgkb18AkE/giphy.gif")
                                                        ),
                                                        div(
                                                          class = "intro-box",
                                                          p("The Digitalis Investigation Group (DIG) trial was the first large simple trial conducted by the National Heart, Lung, and Blood Institute in conjunction with the Department of Veterans Affair."),
                                                          p("The Digitalis Investigation Group (DIG) study was a prospective, randomized clinical trial involving 7,788 patients with HF randomized to digoxin or placebo and followed for an average of 37 months."),
                                                          p("Interactions between age and the following clinical outcomes were examined: total mortality, all-cause hospitalizations, HF hospitalizations, the composite of HF death or HF hospitalizations, hospitalization for suspected digoxin toxicity and withdrawal from therapy because of side effects."),
                                                          p("A total of 302 centers in the United States and Canada enrolled 7,788 patients between February 1991 and September 1993.")
                                                        ),
                                                        div(
                                                          class = "image-container",
                                                          img(src = "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExazBtamw1NWtjeHVoa2Z1ejJybGxyMnQ2czhjejVrNjRxcXYyZHR0NyZlcD12MV9naWZzX3NlYXJjaCZjdD1n/3o85xm0pDVY4EkKdFe/giphy.gif", 
                                                              class = "circle-image")
                                                        )
                                                      )
  )
  ),
  
  # Data Exploration Tab
  tabPanel(
    "Data Exploration: Visualisation of DIG Trial outcomes",
    fluidPage(
      div(
        class = "visualization-info",
        h3("Visual Data Exploration: Results of DIG Trial"),
        p("This section displays various visualizations based on the Digitalis Investigation Group (DIG) trial data. You can explore the relationship between different clinical variables, treatment groups, and patient characteristics through scatter plots, mosaic plots, and bar charts. Use the controls to filter data by age, gender, and other factors.")
      ),
      sidebarLayout(
        sidebarPanel(
          sliderInput("age_range", "Age Range", min = 30, max = 100, value = c(30, 100)),
          selectizeInput("gender", "Gender", choices = c("All", "Male", "Female"), selected = "All"),
          selectizeInput("variable", "Variable",
                         choices = c("BMI", "KLEVEL", "CREAT", "DIABP", "SYSBP", "HOSPDAYS"), selected = "BMI"),
          downloadButton("download_data", "Download Filtered Data"),
          tags$img(src = "https://www.digitalis-cdc.com/digitalisshowcase/ui/img/digitalis-flat-1200x800.png",
                   style = "width: 100%; height: auto; margin-top: 20px;")
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Interactive Scatter Plot", plotlyOutput("scatter_plot")),
            tabPanel("Mosaic Plot", plotlyOutput("mosaic_plot")),
            tabPanel(
              "Static Bar Charts",
              fluidRow(
                column(6, plotlyOutput("mortality_plot")),
                column(6, plotlyOutput("cvd_mortality_plot"))
              )
            ),
            tabPanel(
              "Static Survival Plot",
              fluidPage(
                div(
                  class = "static-survival-plot",
                  h3("Static Survival Plot"),
                  p("This plot shows the risk of mortality over time by treatment group and the presence or absence of cardiovascular disease (CVD). It helps to visualize how CVD affects the mortality risk in patients under different treatments."),
                  img(src = "survival.png", style = "width: 100%; height: auto; margin-top: 20px;")  
                )
              )
            )
          )
        )
      )
    )
  ),
  
  # Summary Page
  tabPanel(
    "Summary",
    fluidPage(
      tags$head(
        tags$style(HTML("
          .summary-table-section {
            background-color: #2C3E50;
            padding: 20px;
            color: white;
            border-radius: 10px;
            margin-bottom: 20px;
          }
           
                                                      
