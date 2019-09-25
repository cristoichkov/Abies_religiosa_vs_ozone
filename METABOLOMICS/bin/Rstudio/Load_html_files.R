# first option

rawHTML <- paste(readLines("../../metadata/GC-MS/LibSrch_10.htm"), collapse="\n")

# second option xml2 and rvest

library(xm12)
library(rvest)
html_dat <- read_html(
  system.file("../../metadata/GC-MS/LibSrch_10.htm", package = "textreadr")
)
