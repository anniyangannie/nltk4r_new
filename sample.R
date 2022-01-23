#This file should be used with RStudio
library('devtools')
library('reticulate')
devtools::install_github("Manuellama/nltk4r")

# replace with path of your choice
my_env <- "./env"

# create a virtual environment (tested on unix)
args <- paste("-m venv", my_env)
system2("python3", args) 

# force reticulate to use env
reticulate::use_virtualenv(my_env, required = TRUE)

# install gensim & scikit-learn in environment
nltk4r::install_nltk(my_env) 
reticulate::py_install("nltk")

nltk <- reticulate::import("nltk")
nltk$download('punkt')
nltk$download("maxent_ne_chunker")
nltk$download("words")

str <- paste(
  "R is a programming language and free software environment",
  "for statistical computing and graphics supported by the R Foundation",
  "for Statistical Computing."
)

tokens <- nltk$word_tokenize(str)


# Parts of speech
pos <- nltk$pos_tag(tokens)

chunks <- nltk$ne_chunk(pos)

# convert to text
txt <- nltk$Text(tokens)

# generate
txt$generate()
#> for Statistical Computing . and graphics supported by the R Foundation
#> for Statistical Computing . R Foundation for Statistical Computing .
#> software environment for statistical computing and graphics supported
#> by the R Foundation for Statistical Computing . Statistical Computing
#> . computing and graphics supported by the R Foundation for Statistical
#> Computing . by the R Foundation for Statistical Computing . Foundation
#> for Statistical Computing . the R Foundation for Statistical Computing
#> . for statistical computing and graphics supported by the R Foundation
#> for Statistical Computing . statistical computing and graphics
#> supported by the R Foundation for Statistical Computing . the
