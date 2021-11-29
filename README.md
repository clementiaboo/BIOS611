# README 

## About the Dataset

#### This dataset was originally collected by researchers at the University of Minho in Braga, Portugal. The data is a sample of high school students obtained through a survey of students taking Math and Portuguese language courses at two high schools in Portugal: Gabriel Pereira and Mousinho da Silveira. Each observation represents the survey response of a single student. There are 33 variables. To avoid issues like duplicate students and differences in grades due to overall course difficulty (Math vs Portuguese), this analysis will only focus on the data containing survey responses of students in the Portuguese language class. The Portuguese language class dataset is composed of 649 unique student survey responses. https://www.kaggle.com/uciml/student-alcohol-consumption

## How to Build and Run Container
You will need to have Docker installed. 

`docker build . -t 611`
`docker run -v $(pwd):/home/rstudio/project -p 8787:8787 -e PASSWORD=pw`

Use a good password, not pw. 

This will start rstudio, visit localhost:8787 in your browser. 

## Using the Makefile

In the rstudio terminal, type 

`make derived_data/studalc.csv`

## Report
To build the final report: 

`make report.pdf`
 
