library(shiny)
library(ggplot2)
library(CHNOSZ)
library(methanogenlab)
gridlinecolor <- "grey80"
gridlinecolorminor <- "grey100"
function(input, output) {

  dataset <- reactive({
    methanogenesis(CH4.initial = input$ch4.initial,
                   H2.initial = input$h2.initial,
                   DIC.initial = input$dic.initial,
                   pH.initial = input$ph.initial,
                   temperature = input$temperature+273.15,
                   VolumeSolution = input$vol.soln*1e-3,
                   VolumeHeadspace = input$vol.head*1e-3,
                   delta.DIC = 0.0001,
                   biomass.yield = input$biomass.yield,
                   carbon.fraction=0.44,
                   inoculum.cell.number = input$inoculum)
  })

  output$plot <- renderPlot({

    p <- ggplot(dataset(), aes(x=get(input$x), y=get(input$y))) + geom_line(size=1)+ geom_point(size=2)+
      xlab(input$x)+
      ylab(input$y)+
      theme(panel.border = element_rect(fill=NA, size=1),
            axis.text = element_text(colour="black", size =10),
            panel.background = element_blank(), 
            axis.title = element_text(colour="black", size =14,face="bold"),
            panel.grid.major = element_line(colour = gridlinecolor),
            panel.grid.minor = element_line(colour = gridlinecolorminor))

    print(p)

  }, height=700)

}

