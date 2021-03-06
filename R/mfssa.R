# Embedding and decomposition stages of multivariate functional singular spectrum analysis.
mfssa <- function(Y, L = floor(Y$N/2L)){
  # get c plus plus code
  p <- Y$p
  d <- L*matrix(c(0,Y$d),nrow = 1L, ncol = (p+1L))
  N <- Y$N
  B <- list()
  A <- list()
  # get inner product matrices
  for(i in 1:p){
    B[[i]] <- inprod(Y[[i]],Y[[i]]$basis)
    A[[i]] <- inprod(Y[[i]]$basis,Y[[i]]$basis)
  }
  # Find the proper inner product matrices for j_k variables
  d_tilde <- sum(d)/L
  K <- N - L + 1L
  shifter <- matrix(nrow = 2, ncol = (p+1L), data=0L)
  shifter[,2L] <- c(1L,d[2L])
  if(p > 1L){
    for(i in 2L:p){
      shifter[1L,i+1L]=shifter[2L,i]+1L
      shifter[2L,i+1L]=shifter[2L,i]+d[i+1L]
    }
  }
  # find the desired matrices
  S_0 <- SSM(K, L, d_tilde, p, B, shifter)
  G <- Gramm(K,L,p,d_tilde,A,shifter,d)
  S <- solve(G)%*%S_0 # S matrix which parameterizes var/cov op.
  Q <- eigen(S)
  coefs0 <- Re(Q$vectors)
  p_c <- list()
  r <- sum(Re(Q$values) > 0.001)
  values <- Re(Q$values[1L:r])
  out <- list()
  for(i in 1L:(r)){
    my_pcs <- list(NA)
    for(j in 1L:p){
      my_pcs[[j]] <- fd(Cofmat((d[j+1L]/L), L, coefs0[(shifter[1L,(j+1L)]:shifter[2L,(j+1L)]),i]),Y[[j]]$basis)
    }
    out[[i]] <- my_pcs
  }
  out$values <- values
  out$L <- L
  out$N <- N
  out$Y <- Y
  out$RVectrs <- mV(out,r)
  return(out)
}
