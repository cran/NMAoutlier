% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/NMAoutlier.measures.R
\name{NMAoutlier.measures}
\alias{NMAoutlier.measures}
\title{Outlier and influential detection measures in network meta-analysis.}
\usage{
NMAoutlier.measures(
  TE,
  seTE,
  treat1,
  treat2,
  studlab,
  data = NULL,
  sm,
  reference = "",
  measure = "simple",
  ...
)
}
\arguments{
\item{TE}{Estimate of treatment effect, i.e. difference between
first and second treatment (e.g. log odds ratio, mean difference,
or log hazard ratio).}

\item{seTE}{Standard error of treatment estimate.}

\item{treat1}{Label/Number for first treatment.}

\item{treat2}{Label/Number for second treatment.}

\item{studlab}{Study labels (important when multi arm studies are
included).}

\item{data}{A data frame containing the study information.}

\item{sm}{A character string indicating underlying summary measure,
e.g., \code{"RD"}, \code{"RR"}, \code{"OR"}, \code{"ASD"},
\code{"HR"}, \code{"MD"}, \code{"SMD"}, or \code{"ROM"}.}

\item{reference}{Reference treatment group.}

\item{measure}{Outlier and influential detection measures, simple
measures (default: "simple") or outlier and influential detection
measures considered study deletion (measure = "deletion").}

\item{\dots}{Additional arguments passed on to
\code{\link[netmeta]{netmeta}}.}
}
\value{
An object of class \code{NMAoutlier.measures};
with a list containing the following components when choosing simple measures:
   \item{dat}{Matrix containing the data \code{"TE"}, \code{"seTE"}, \code{"studlab"}, \code{"treat1"}, \code{"treat2"} as defined above.}
   \item{eraw}{Raw residual for each study included in the network.}
   \item{estand}{Standardized residual for each study included in the network.}
   \item{estud}{Studentized residual for each study included in the network.}
   \item{Mah}{Mahalanobis distance for each pairwise comparison.}
   \item{Mah.distance}{Mahalanobis distance for each study included in the network.}
   \item{leverage}{Leverage for each study included in the network.}
   \item{measure}{type of measure used.}
   \item{call}{Function call}

a list containing the following components,when choosing deletion measures:
   \item{dat}{Matrix containing the data \code{"TE"}, \code{"seTE"}, \code{"studlab"}, \code{"treat1"}, \code{"treat2"} as defined above.}
   \item{eraw.deleted}{Raw deleted residual for each study included in the network.}
   \item{estand.deleted}{Standardized deleted residual for each study included in the network.}
   \item{estud.deleted }{Studentized deleted residual for each study included in the network.}
   \item{Cooks.distance}{Cook distance between the treatment estimates for study j and treatment estimates when study j is removed}
   \item{Covratio}{Ratio of determinants of variance-covariance matrix of treatment estimates for study j to treatment estimates when study j is removed.}
   \item{w.leaveoneout}{Weight leave one out.}
   \item{H.leaveoneout}{Leverage leave one out.}
   \item{heterog.leaveoneout}{Heterogeneity estimator leave one out.}
   \item{Rheterogeneity}{R statistic for heterogeneity.}
   \item{Restimates}{R statistis for estimates.}
   \item{RQtotal}{R statistic for Q (\code{Qtotal}).}
   \item{RQhet}{R statistic for  heterogeneity Q (\code{Qhet}).}
   \item{RQinc}{R statistic for Qinconsistency (\code{Qinc}).}
   \item{DFbetas}{DFbetas.}
   \item{measure}{type of measure used.}
   \item{call}{Function call}
}
\description{
This function calculates several (simple or/and deletion) measures
for detection of outliers and influential studies in network
meta-analysis.

Outlier and influential detection measures are: \itemize{ \item
Simple outlier and influential measures for each study (Raw
residuals, Standardized residuals, Studentized residuals,
Mahalanobis distance, leverage).  \item Outlier and influential
deletion measures for each study (Shift the mean) (Raw deleted
residuals, Standardized deleted residuals, Studentized deleted
residuals, Cook distance between the treatment estimates for study
j and treatment estimates when study j is removed; Ratio of
determinants of variance-covariance matrix of treatment estimates
for study j to treatment estimates when study j is removed; weight
leave one out;leverage leave one out; heterogeneity estimator leave
one out; R statistic for heterogeneity; R statistic for Q
(\code{Qtotal}), R statistic for heterogeneity Q (\code{Qhet}), R
statistic for Qinconsistency (\code{Qinc}), DFbetas.)  }
}
\details{
Outlier and influential detection measures (simple or deletion) for network meta-analysis.
Network meta-analysis from graph-theory [Rücker, 2012] is fitted
with (\code{netmeta} function) of R package \bold{netmeta} [Rücker et al., 2015].

A description of the outlier and influential detection measures in the context of network meta-analysis
can be found in Petropoulou (2020).

Let \emph{n} be the number of treatments in a network and let
\emph{m} be the number of pairwise treatment comparisons.  If there
are only two-arm studies, \emph{m} is the number of studies. Let
\code{TE} and \code{seTE} be the vectors of observed effects and their standard
errors. Comparisons belonging to multi-arm studies are identified
by identical study labels (argument \code{studlab}).

This function calculates outlier and influential detection measures for each study.
Simple outlier and influential measures (\code{measure} = "simple") are:
Raw residuals, Standardized residuals, Studentized residuals, Mahalanobis distance
and leverage for each study.
For deletion outlier and influential measures (\code{measure} = "deletion"):
Standardized deleted residual; Studentized deleted residual; Cook distance between the treatment estimates for study j
and treatment estimates when study j is removed;
Ratio of determinants of variance-covariance matrix of treatment estimates for study j to treatment estimates when study j is removed;
Weight leave one out;leverage leave one out; heterogeneity estimator leave one out;
R statistic for heterogeneity;  R statistis for estimates; R statistic for Q (\code{Qtotal}),  R statistic for  heterogeneity Q
(\code{Qhet}), R statistic for Qinconsistency (\code{Qinc}), DFbetas.
}
\examples{
library("netmeta")
data(smokingcessation)
smokingcessation$id <- 1:nrow(smokingcessation)

study912 <- subset(smokingcessation, id \%in\% 9:12)
p1 <- pairwise(list(treat1, treat2, treat3),
  list(event1, event2, event3), list(n1, n2, n3),
  data = study912, sm = "OR")

# Outlier and influential detection measures for studies 9, 10, 11, 12
meas <- NMAoutlier.measures(p1)

# Standardized residual for each study included in the network
meas$estand

\dontrun{
# Outlier and influential deletion measures for studies 9, 10, 11, 12.
delete <- NMAoutlier.measures(p1, measure = "deletion")

# Standardized deleted residual for studies 9, 10, 11, 12.
delete$estand.deleted

data(smokingcessation)

# Transform data from arm-based to contrast-based format
# We use 'sm' argument for odds ratios.
# We use function pairwise from netmeta package
#
p1 <- pairwise(list(treat1, treat2, treat3),
  list(event1, event2, event3), list(n1, n2, n3),
  data = smokingcessation, sm = "OR")

# Outlier and influential detection measures for each study in the network
meas <- NMAoutlier.measures(p1, measure = "simple")

# Mahalanobis distance for each study included in the network
meas$Mah
}

}
\references{
Rücker G (2012):
Network meta-analysis, electrical networks and graph theory.
\emph{Research Synthesis Methods},
\bold{3}, 312--24

Rücker G, Schwarzer G (2015):
Ranking treatments in frequentist network meta-analysis works
without resampling methods.
\emph{BMC Medical Research Methodology},
\bold{15}, 58

Petropoulou M (2020):
Exploring methodological challenges in network meta-analysis models and
developing methodology for outlier detection.
\emph{PhD dissertation}
}
\author{
Maria Petropoulou <maria.petropoulou@uniklinik-freiburg.de>
}
