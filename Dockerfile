#### make sure Docker is runnning

FROM cmd
RUN docker run -d --name=rstudio --rm -p 8787:8787 -e PASSWORD=password rocker/rstudio 
#### search `localhost:8787` in browser
#### login using username = "rstudio", password = "password"

FROM rstudio
RUN R -e "install.packages(c(\"shiny\",\"plotly\"))";
RUN R -e "install.packages(\"tidyverse\")";
RUN R -e "install.packages(\"ggplot2\")";
RUN R -e "install.packages(\"dplyr\")";
RUN R -e "install.packages(\"Rcpp\")";
RUN R -e "install.packages(\"reticulate\")";
RUN R -e "install.packages(\"ppclust\")";
RUN R -e "install.packages(\"gbm\")";
RUN R -e "install.packages(\"rdist\")";
RUN R -e "install.packages(\"caret\")";
