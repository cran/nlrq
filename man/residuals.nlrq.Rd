\name{residuals.nlrq}
\alias{residuals.nlrq}
\title{ Return residuals of an nlrq object }
\description{
Set algorithmic parameters for nlrq (nonlinear quantile regression function)
}
\usage{
residuals.nlrq(nlrqObject, type = c("response", "rho"), ...) 
{
    type <- match.arg(type)
    val <- as.vector(object$m$resid())
    if (type == "rho") {
        tau <- object$m$tau()
        val <- tau * pmax(val, 0) + (1 - tau) * pmin(val, 0)
        attr(val, "label") <- paste("quantile residuals rho(", tau ,")", sep="")
    }
    else {
        lab <- "Residuals"
        if (!is.null(aux <- attr(object, "units")$y)) {
            lab <- paste(lab, aux)
        }
        attr(val, "label") <- lab
    }
    val
}
residuals.nlrq(maxiter=100, k=2, big=1e+20, eps=1e-07, beta=0.97)
}
\arguments{
  \item{nlrqObject}{an `nlrq' object as returned by function `nlrq'}
  \item{type}{the type of residuals to return: "response" is the distance
  between observed and predicted values; "rho" is the weighted distance used
  to calculate the objective function in the minimisation algorithm as 
  tau * pmax(resid, 0) + (1 - tau) * pmin(resid, 0), where resid are the
  simple residuals as above (with type="response").
  }
}
\seealso{  \code{\link{nlrq}} }

\keyword{models}  
\keyword{regression}
\keyword{nonlinear}
