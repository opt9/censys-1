% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/export.r
\name{censys_start_export}
\alias{censys_start_export}
\title{Export large datasets and structured records from Censys to JSON or CSV files}
\usage{
censys_start_export(query, format = c("csv", "json"), flatten = TRUE,
  compress = FALSE, delimiter = ",", headers = TRUE)
}
\arguments{
\item{query}{the SQL query to be executed}

\item{format}{the format data should be output in. Must be \code{csv} or \code{json}.
Default: \code{csv}.}

\item{flatten}{should nested and repeated fields in the query results be flattened. Default: \code{true}.}

\item{compress}{should data files be gzipped. Default: \code{false}.}

\item{delimiter}{delimiter to use between fields in the exported data. Default: \code{","}.}

\item{headers}{should a header row be included in results files. Default: \code{true}.}
}
\value{
API call result (invisibly)
}
\description{
The Export API allows exporting large datasets and structured records from Censys to
JSON or CSV files. Unlike the query endpoint, there are no limits on the type or amount
of data returned.
}
\details{
Exports are executed as asynchronous jobs. You must first start a job. If the query is
parsed successfully, the call will return a job ID, which is used in subsequent calls
to get job. Once a job executes successfully, the get job endpoint will provide a list
of 128MB JSON files that are available for download for 24 hours. Jobs typically
require 15-30 seconds to execute.

You must have both \code{CENSYS_API_ID} and \code{CENSYS_API_SECRET} present in the
R environment for the functions in this package to work. It is highly suggested that
you place those in \code{~/.Renviron} at least for interactive work.
}
\examples{
\dontrun{
q <- censys_start_export("
SELECT location.country, count(ip) FROM ipv4.20161206 GROUP BY location.country
")
censys_export_job_status(q$job_id)
censys_export_download(q$job_id, "~/Data")
}
}
\references{
Censys SQL query syntax: \url{https://censys.io/query};
            API doc: \url{https://censys.io/api/v1/docs/export}
}

