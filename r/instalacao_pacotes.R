# Troubleshooting
# Funcionar extensão do R no VS Code
install.packages('jsonlite', dependencies=TRUE, repos='http://cran.rstudio.com/')
#Some packages might fail to install and an error with libicui*** is printed.
#To fix this install the following package in R
install.packages(stringi)