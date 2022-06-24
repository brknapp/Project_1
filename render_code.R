rmarkdown::render("README.Rmd",
                  output_format = "github_document",
                  output_options = list(
                    toc = TRUE,
                    html_preview=FALSE) 
)