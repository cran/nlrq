\name{nlrq}
\alias{nlrq}, 
\alias{nlrqModel}
\alias{print.nlrq} 
\alias{summary.nlrq} 
\alias{deviance.nlrq}
\alias{formula.nlrq} 
\alias{coef.nlrq} 
\alias{fitted.nlrq} 
\alias{predict.nlrq} 
\alias{print.summary.nlrq} 
\alias{tau.nlrq}
\title{ Function to compute nonlinear quantile regression estimates}
\description{
This function implements an R version of an interior point method
for computing the solution to quantile regression problems which
are nonlinear in the parameters.  The algorithm is based on interior
point ideas described in Koenker and Park (1994).
}
\usage{
nlrq(formula, data=parent.frame(), start, tau=0.5, control, trace=FALSE)
}
\arguments{
  \item{formula}{ formula for model in nls format; accept self-starting models }
  \item{data}{ an optional data frame in which to evaluate the variables in
	 `formula' }
  \item{start}{a named list or named numeric vector of starting estimates }
  \item{tau}{ a vector of quantiles to be estimated}
  \item{control}{ an optional list of control settings.  See `nlrq.control' for
          the names of the settable control values and their effect.}
  \item{trace}{ logical value indicating if a trace of the iteration progress
          should be printed.  Default is `FALSE'.  If `TRUE' intermediary results
          are printed at the end of each iteration. } 
}
\details{An `nlrq' object is a type of fitted model object.  It has methods
     for the generic functions `coef' (parameters estimation at best solution),
     `formula' (model used), `deviance' (value of the objective function at best 
     solution), `print', `summary', `fitted' (vector of fitted variable according
     to the model), `predict' (vector of data points predicted by the model, using
     a different matrix for the independent variables) and also for the function
     `tau' (quantile used for fitting the model, as the tau argument of the
     function). Further help is also available for the method `residuals'.
}


\value{
  A list consisting of: 
  \item{m}{an `nlrqModel' object similar to an `nlsModel' in package nls}
  \item{data }{the expression that was passed to `nlrq' as the data argument.
           The actual data values are present in the environment of the
          `m' component. }
}

\author{Based on S code by Roger Koenker modified for R and to accept same models
as nls by Philippe Grosjean.}

\references{ Koenker, R. and Park, B.J. (1994). An Interior Point Algorithm for
Nonlinear Quantile Regression, Journal of Econometrics, 71(1-2): 265-283.
}

\seealso{  \code{\link{nlrq.control}} , \code{\link{residuals.nlrq}} }

\examples{
# Example using model defined in the nls library
library(nls)
# build artificial data with multiplicative error
Dat <- NULL; Dat$x <- rep(1:25, 20)
set.seed(1)
Dat$y <- SSlogis(Dat$x, 10, 12, 2)*rnorm(500, 1, 0.1)
plot(Dat)
# fit first a classical least-square regression
Dat.nls <- nls(y ~ SSlogis(x, Asym, mid, scal), data=Dat); Dat.nls
lines(1:25, predict(Dat.nls, newdata=list(x=1:25)), col=1)
# then fit the median using nlrq
Dat.nlrq <- nlrq(y ~ SSlogis(x, Asym, mid, scal), data=Dat, tau=0.5, trace=TRUE)
lines(1:25, predict(Dat.nlrq, newdata=list(x=1:25)), col=2)
# the 1st and 3rd quartiles regressions
Dat.nlrq <- nlrq(y ~ SSlogis(x, Asym, mid, scal), data=Dat, tau=0.25, trace=TRUE)
lines(1:25, predict(Dat.nlrq, newdata=list(x=1:25)), col=3)
Dat.nlrq <- nlrq(y ~ SSlogis(x, Asym, mid, scal), data=Dat, tau=0.75, trace=TRUE)
lines(1:25, predict(Dat.nlrq, newdata=list(x=1:25)), col=3)
# and finally "external envelopes" holding 95% of the data
Dat.nlrq <- nlrq(y ~ SSlogis(x, Asym, mid, scal), data=Dat, tau=0.025, trace=TRUE)
lines(1:25, predict(Dat.nlrq, newdata=list(x=1:25)), col=4)
Dat.nlrq <- nlrq(y ~ SSlogis(x, Asym, mid, scal), data=Dat, tau=0.975, trace=TRUE)
lines(1:25, predict(Dat.nlrq, newdata=list(x=1:25)), col=4)
leg <- c("least squares","median (0.5)","quartiles (0.25/0.75)",".95 band (0.025/0.975)")
legend(1, 12.5, legend=leg, lty=1, col=1:4)
}
\keyword{models}  
\keyword{regression}
\keyword{nonlinear}
\keyword{robust}
