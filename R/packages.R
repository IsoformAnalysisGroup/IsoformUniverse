# IsoformUniverse package registry
#
# This file defines the list of packages managed by IsoformUniverse.
#
# ── How to add a new package ─────────────────────────────────────────────────
#
# 1. Add a new row to `.isoformverse_pkgs` below.
#    Fill in:
#      * `package` – the exact R package name (case-sensitive).
#      * `source`  – one of "Bioconductor" or "GitHub".
#      * `repo`    – the "owner/repo" GitHub path for GitHub packages, or
#                    NA_character_ for Bioconductor packages (they are
#                    identified by name alone).
#
# 2. Regenerate documentation:
#      devtools::document()
#
# 3. Add an entry to NEWS.md so users know a new package was added.
#
# ─────────────────────────────────────────────────────────────────────────────

# Internal package registry.
# Columns:
#   package – R package name
#   source  – "Bioconductor" | "GitHub"
#   repo    – GitHub "owner/repo" path, or NA for Bioconductor
.isoformverse_pkgs <- data.frame(
  package = c(
    "pairedGSEA",
    "IsoformSwitchAnalyzeR"
  ),
  source = c(
    "Bioconductor",
    "GitHub"
  ),
  repo = c(
    NA_character_,
    "kvittingseerup/IsoformSwitchAnalyzeR"
  ),
  stringsAsFactors = FALSE
)

#' List all IsoformUniverse packages
#'
#' Returns a data frame describing every package that belongs to the
#' IsoformUniverse ecosystem.  Each row is one package.
#'
#' @return A `data.frame` with three columns:
#'   \describe{
#'     \item{`package`}{The R package name (character).}
#'     \item{`source`}{Where the package is hosted: `"Bioconductor"` or
#'       `"GitHub"` (character).}
#'     \item{`repo`}{For GitHub packages, the `"owner/repo"` path needed by
#'       [remotes::install_github()].  `NA` for Bioconductor packages
#'       (character).}
#'   }
#'
#' @section Adding packages:
#' Edit the internal `.isoformverse_pkgs` data frame in `R/packages.R`.
#' See the comments at the top of that file for step-by-step instructions.
#'
#' @export
#' @examples
#' isoformUniverse_packages()
isoformUniverse_packages <- function() {
  .isoformverse_pkgs
}
