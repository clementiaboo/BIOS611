FROM rocker/verse 
RUN R -e "install.packages(c(\"shiny\",\"plotly\",\"glmnet\",\"kableExtra\",\"leaps\",\"gridExtra\"))";
RUN R -e "install.packages(\"tinytex\")"
RUN R -e "tinytex::install_tinytex()"
