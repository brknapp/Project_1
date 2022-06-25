#author: Bridget Knapp
#date: 6/25/2022
#purpose of the program: Code to create the README.md file
###################################

rmarkdown::render("README.Rmd",
                  output_format = "github_document",
                  output_options = list(
                    toc = TRUE,
                    html_preview=FALSE) 
)