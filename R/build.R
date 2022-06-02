options(stringsAsFactors = FALSE)
cargs = commandArgs(TRUE)
local = cargs[1] == 'TRUE'

build_one = function(io, external = FALSE)  {
  # if output is not older than input, skip the compilation
  if (!blogdown:::require_rebuild(io[2], io[1])) return()

  if (local) message('* knitting ', io[1])
  if (blogdown:::Rscript(shQuote(c('R/build_one.R', io, external))) != 0) {
    unlink(io[2])
    stop('Failed to compile ', io[1], ' to ', io[2])
  }
}

# external Rmd files
files = read.csv('R/external_Rmd.csv', strip.white = TRUE)
if (nrow(files) != 0) {
  files = cbind(as.matrix(files), external = TRUE)
}

# Rmd files under the content directory
rmds = list.files('content', '[.]Rmd$', recursive = TRUE, full.names = TRUE)
if (length(rmds)) {
  files = rbind(files, cbind(rmds, blogdown:::with_ext(rmds, '.md'), FALSE))
}

for (i in seq_len(nrow(files))) {
  build_one(unlist(files[i, 1:2]), files[i, 3])
}

blogdown:::hugo_build(local = local)

if (FALSE) {
  checkJS = function(name) {
    api = sprintf('https://api.bootcdn.cn/libraries/%s.json', name)
    jsonlite::fromJSON(api)$version
  }
  checkJS('highlight.js')
  checkJS('mathjax')
}
