# README 

## Introduction
Grades and test scores—these are, in nearly all contemporary academic settings, the sole representations of student success. The focus of my analysis is to delve into the many relationships between student information and school performance and extract those characteristics that seem to have the greatest impact on a student’s performance in school. 

## About the Dataset
This dataset was originally collected by researchers at the University of Minho in Braga, Portugal. The data is a sample of high school students obtained through a survey of students taking Math and Portuguese language courses at two high schools in Portugal: https://www.kaggle.com/uciml/student-alcohol-consumption

## How to Build and Run Container

### Windows 
You will need to have Docker installed. Then run 


`docker build . -t 611`


`docker run -v ${pwd}:/home/rstudio/project -p 8787:8787 -e PASSWORD=pw -t 611`


Open a new terminal window and run 
`docker exec -it <container-id> sh`


This will start rstudio, visit localhost:8787 in your browser. Login using username = rstudio password = pw

### Mac
Run


`docker build . -t 611`


`docker run -v $(pwd):/home/rstudio/project -p 8787:8787 -e PASSWORD=pw -t 611`


This will start rstudio, visit localhost:8787 in your browser. Login using username = rstudio password = pw

## Report
To build the final report: 

`make report.pdf`
 
