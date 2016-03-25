library(shiny)
library(HistData)
data(GaltonFamilies)
library(dplyr)
library(ggplot2)


gf <- GaltonFamilies

# use a reasonably simple linear model
regmod <- lm(childHeight ~ father + mother + gender, data=gf)

shinyServer(function(input, output) {

  output$prediction <- renderText({
    df <- data.frame(father=input$inFh,
                     mother=input$inMh,
                     gender=factor(input$inGen, levels=levels(gf$gender)))
    ch <- predict(regmod, newdata=df)
    sord <- ifelse(
      input$inGen=="female",
      "daugther",
      "son"
    )
    paste0("Based on the inputs, height of the child is approximately ",
           (strong(round(ch, 1))),
           " inches"
    )
  })
  output$barsPlot <- renderPlot({
    sord <- ifelse(
      input$inGen=="female",
      "Daugther",
      "Son"
    )
    df <- data.frame(father=input$inFh,
                     mother=input$inMh,
                     gender=factor(input$inGen, levels=levels(gf$gender)))
    ch <- predict(regmod, newdata=df)
    yvals <- c("Father", sord, "Mother")
    df <- data.frame(
      x = factor(yvals, levels = yvals, ordered = TRUE),
      y = c(input$inFh, ch, input$inMh),
      looks <- c("lightBlue", "grey", "lightBlue")
    )
    ggplot(data=df, aes(x=x, y=y, fill=NULL)) +
      ggtitle("Predicted Height Visualization")+
      geom_bar (stat="identity", width=0.12,show.legend=TRUE,fill = looks) +
      xlab("") +
      ylab("Height (inch)") +
      theme_grey(base_size = 22, base_family = "sans") +
      theme(legend.position="none")

  })
})