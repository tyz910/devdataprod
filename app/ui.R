library(shiny)

shinyUI(fluidPage(
  titlePanel("Would you have survived the Titanic?"),

  sidebarLayout(
    sidebarPanel(
      p("Please pick your age, sex and economic status for view the survival statistics."),
      selectInput("sex", "Sex:", c("Male", "Female")),
      selectInput("age", "Age:", c("Adult", "Child")),
      selectInput("class", "Class:", c("1st", "2nd", "3rd", "Crew")),
      p("Try your luck by pressing button below."),
      actionButton("guess", "Have I survived?")
    ),

    mainPanel(
      h3(textOutput("result")),
      textOutput("percent"),
      plotOutput("distPlot")
    )
  )
))
