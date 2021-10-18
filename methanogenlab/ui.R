library(shiny)
library(ggplot2)
library(CHNOSZ)
library(methanogenlab)
dataset <- methanogenesis(CH4.initial = 1e-6,
                          K.CH4 = 0.00112896948941469,
                          H2.initial = 5e-4,
                          K.H2 = 0.000666251556662516,
                          DIC.initial = 3.2e-3,
                          pH.initial = 7.5,
                          K.CO2 = 0.0234646,
                          #K.CO2HCO3 = K.CO2HCO3,
                          #K.HCO3CO3 = K.HCO3CO3,
                          temperature = 273.15+40,
                          VolumeSolution = 80e-3,
                          VolumeHeadspace = 20e-3,
                          delta.DIC = 0.0001,
                          biomass.yield = 2.4,
                          carbon.fraction=0.44,
                          inoculum.cell.number = 0)

fluidPage(
#total widths must add to 12
  titlePanel("Methanogen Lab"),
  
  sidebarPanel(
    numericInput('vol.soln','Volume Solution (mL)',value=80),
    numericInput('vol.head','Volume Headspace (mL)',value=20),
    numericInput('temperature','Temperature (C)',value = 40),
    numericInput('biomass.yield','Biomass Yield',value = 2.4),
    selectInput('x', 'X', "DIC.consumed"),
    selectInput('y', 'Y', names(dataset), "systempH.step"),
    width = 2),
  
  sidebarPanel(
    sliderInput('ch4.initial','CH4 Initial (uM)',min=1e-6,max=1e-5,value = 1e-6,step = 1e-6),
    sliderInput('h2.initial','H2 Initial (mM)',min = 1e-4,max = 1e-2,value = 5e-4,step = 1e-4),
    sliderInput('dic.initial','DIC Initial (mM)',min = 1e-3,max = 1e-2,value = 3.2e-3,step = 1e-3),
    sliderInput('ph.initial','pH Initial',min=0,max=14,value = 7.5,step = 0.1),
    shinyWidgets::sliderTextInput('inoculum','Inoculum Cell Number',choices=c(0,1e2,1e3,1e4,1e5,1e6,1e7,1e8,1e9,1e10),selected = 0, grid = T),
    width = 3

  ),

  mainPanel(
    plotOutput('plot'),
    width = 7
  )
)
