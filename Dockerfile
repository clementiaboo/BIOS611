FROM rocker/verse #

FROM rstudio
RUN R -e "install.packages(c(\"shiny\",\"plotly\",\"glmnet\",\"kableExtra\",\"leaps\",\"gridExtra\"))";

