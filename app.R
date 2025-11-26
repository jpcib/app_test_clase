library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("La vieja y confiable data de géiseres"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Número de bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      
      sliderInput("range",
                  "Rango de tiempos de espera:",
                  min = 40,
                  max = 100,
                  value = c(40, 100),
                  step = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- faithful[, 2]
    
    # Filter data based on range slider
    x <- x[x >= input$range[1] & x <= input$range[2]]
    
    # Only plot if there's data in the range
    if(length(x) > 0) {
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white',
           xlab = 'Tiempo para la próxima erupción (en minutos)',
           main = 'Histograma de tiempos de espera',
           xlim = input$range)
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)