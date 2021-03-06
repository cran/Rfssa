# Reconstruction stage (including Hankelization) of univariate functional singular spectrum analysis

ufreconstruct <- function(U, group = as.list(1L:10L)) {
  N <- U$N
  Y <- U$Y
  d <- U$Y$d
  L <- U$L
  K <- N - L + 1L
  basis <- Y[[1]]$basis
  m <- length(group)
  basis <- U[[1]]$basis
  out <- list()
  for (i in 1L:m) {
    Cx <- matrix(NA, nrow = d, ncol = N)
    g <- group[[i]]
    S <- 0L
    for (j in 1L:length(g)) S <- S + ufproj(U, g[j], d)
    S <- fH(S, d)
    Cx[, 1L:L] <- S[, 1L, ]
    Cx[, L:N] <- S[, ,L]
    out[[i]] <- fts(fd(Cx, basis),time=Y$time)
  }
  out$values <- sqrt(U$values)
  return(out)
}
