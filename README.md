# README 

#### This dataset was originally collected by researchers at the University of Minho in Braga, Portugal. The data is a sample of high school students obtained through a survey of students taking Math and Portuguese language courses at two high schools in Portugal: Gabriel Pereira and Mousinho da Silveira. Each observation represents the survey response of a single student. There are 33 variables. To avoid issues like duplicate students and differences in grades due to overall course difficulty (Math vs Portuguese), this analysis will only focus on the data containing survey responses of students in the Portuguese language class. The Portuguese language class dataset is composed of 649 unique student survey responses. https://www.kaggle.com/uciml/student-alcohol-consumption

#### I split the variables into four categories: response, behavioral, background, and educational. The response variables are G4 and G3. G4 is a binary variable we created based on the given variables G1 and G2, which are the grades for the first and second term; G4 is 1 if G2 is greater than or equal to G1 (indicating improvement from the first term grade) and 0 otherwise. G3 is a numeric variable representing the final grade of a student, given in points out of 20. G1 and G2, mentioned earlier, use the same units as G3. Dragging across the plot returns data from the points selected. 

### Install the following packages in R
`install.packages("tidyverse")`
`install.packages("shiny")`
`install.packages("ggplot2")`
`install.packages("dyplr")`
### Load packages into R
`library(tidyverse)`
`library(shiny)`
`library(ggplot2)`
`library(dyplr)`

### Read in dataset and process it
`studalc <- read.csv("https://raw.githubusercontent.com/clementiaboo/bios-611-project/main/studalc.csv") %>%
  mutate(Gedu = factor(Gedu, 
    levels = c("None", "Primary", "Middle", "Secondary", "Higher"),
    labels = c("Minimal", "Minimal", "Middle", 
               "Secondary", "Higher")), 
    freetime = factor(freetime, c("Very Low", "Low", "Medium", "High", "Very High")), 
    famrel = factor(famrel, c("Very Bad", "Bad", "Neutral", "Good", "Excellent")), 
    G4 = as.factor(G4))`

`studalc %>%
  mutate(G4 = ifelse(G4 == 1, "Increased", "Decreased"))`
### Create shiny plot
`ui <- fluidPage(
  plotOutput("plot", brush = "plot_brush"),
  tableOutput("data")
)
server <- function(input, output, session) {
   output$plot <- renderPlot({
     ggplot(data=studalc, aes(x = G1, y = G2, colour = G4)) + 
  geom_point(position = position_jitter(.3, .3))
   }, res=96)
output$data <- renderTable({
    brushedPoints(studalc, input$plot_brush)
  })
}
shinyApp(ui=ui,server=server,
  options=list(port=8080, host="0.0.0.0"))`
  
#### To run the visualization, search >http://127.0.0.1:8080/ on your web browser.

