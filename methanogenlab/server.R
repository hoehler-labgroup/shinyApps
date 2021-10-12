library(shiny)
library(ggplot2)
library(CHNOSZ)
library(methanogenlab)

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

    p <- ggplot(dataset(), aes(x=get(input$x), y=get(input$y))) + geom_point()+
      xlab(input$x)+
      ylab(input$y)

    # if (input$color != 'None')
    #   p <- p + aes_string(color=input$color)
    #
    # facets <- paste(input$facet_row, '~', input$facet_col)
    # if (facets != '. ~ .')
    #   p <- p + facet_grid(facets)
    #
    # if (input$jitter)
    #   p <- p + geom_jitter()
    # if (input$smooth)
    #   p <- p + geom_smooth()

    print(p)

  }, height=700)

}

