library(shiny)
data(Titanic)
data <- as.data.frame(Titanic)

getSurvived <- function (class, age, sex) {
  stats <- subset(data, Class == class & Sex == sex & Age == age)
  survived <- list(
    "Yes" = subset(stats, Survived == "Yes")[, "Freq"],
    "No"  = subset(stats, Survived == "No")[, "Freq"]
  )

  survived["Total"] <- survived$Yes + survived$No
  if (survived$Total != 0) {
    survived["Percent"] <- round(100 * survived$Yes / survived$Total)
  } else {
    survived["Percent"] <- 0
  }

  return(survived)
}

shinyServer(function (input, output) {
  survived <- reactive({
    getSurvived(input$class, input$age, input$sex)
  })

  output$percent <- renderText({
    paste("Survival probability:", survived()$Percent, "%")
  })

  output$distPlot <- renderPlot({
    barplot(c(survived()$Yes, survived()$No), names = c("Yes", "No"), main = "Survivors")
  })

  output$result <- renderText({
    if (input$guess == 0) {
      return()
    }

    isolate({
      if (!survived()$Total) {
        return("You may survive. Or may not. We have not enough data.")
      }

      if (sample(1:100, 1) <= survived()$Percent) {
        return(paste("Guess #", input$guess, "Congratulations, you have survived!"))
      } else {
        return(paste("Guess #", input$guess, "Sorry, but you have die"))
      }
    })
  })
})