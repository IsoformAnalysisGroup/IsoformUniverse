# Install and update helpers ──────────────────────────────────────────────────

# Ensure a suggested package is available, with an informative error if not.
.check_suggests <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cli::cli_alert_danger(
      "Package {.pkg {pkg}} is required for this operation but is not \\
       installed.  Install it from CRAN with \\
       {.code install.packages(\"{pkg}\")}."
    )
    stop(sprintf("Package '%s' is required but not installed.", pkg),
         call. = FALSE)
  }
}

# Install a single package given a row from `.isoformverse_pkgs`.
.install_one <- function(row, ...) {
  pkg    <- row[["package"]]
  source <- row[["source"]]
  repo   <- row[["repo"]]

  if (source == "Bioconductor") {
    .check_suggests("BiocManager")
    cli::cli_alert_info("Installing {.pkg {pkg}} from Bioconductor ...")
    BiocManager::install(pkg, update = FALSE, ask = FALSE, ...)
  } else if (source == "GitHub") {
    .check_suggests("remotes")
    cli::cli_alert_info("Installing {.pkg {pkg}} from GitHub ({.val {repo}}) ...")
    remotes::install_github(repo, upgrade = "never", ...)
  } else {
    cli::cli_alert_warning("Unknown source {.val {source}} for {.pkg {pkg}}; skipping.")
  }
}

# Update a single package given a row from `.isoformverse_pkgs`.
.update_one <- function(row, ...) {
  pkg    <- row[["package"]]
  source <- row[["source"]]
  repo   <- row[["repo"]]

  if (source == "Bioconductor") {
    .check_suggests("BiocManager")
    cli::cli_alert_info("Updating {.pkg {pkg}} from Bioconductor ...")
    BiocManager::install(pkg, update = TRUE, ask = FALSE, ...)
  } else if (source == "GitHub") {
    .check_suggests("remotes")
    cli::cli_alert_info("Updating {.pkg {pkg}} from GitHub ({.val {repo}}) ...")
    remotes::install_github(repo, upgrade = "always", ...)
  } else {
    cli::cli_alert_warning("Unknown source {.val {source}} for {.pkg {pkg}}; skipping.")
  }
}

# Public API ──────────────────────────────────────────────────────────────────

#' Install IsoformUniverse packages
#'
#' Installs all packages listed in [isoformUniverse_packages()] that are not
#' yet installed on your system.  Packages are fetched from the appropriate
#' source (Bioconductor or GitHub) according to the package registry.
#'
#' * **Bioconductor** packages are installed via
#'   [BiocManager::install()][BiocManager::install].
#' * **GitHub** packages are installed via
#'   [remotes::install_github()][remotes::install_github].
#'
#' Both `BiocManager` and `remotes` must be available; you will receive an
#' informative error if either is missing.
#'
#' @param ... Additional arguments passed to the underlying installer
#'   ([BiocManager::install()] or [remotes::install_github()]).
#'
#' @return Invisibly returns `NULL`.  The function is called for its
#'   side-effect of installing packages.
#' @export
#' @examples
#' \dontrun{
#' isoformUniverse_install()
#' }
isoformUniverse_install <- function(...) {
  pkgs <- isoformUniverse_packages()
  missing_mask <- !vapply(pkgs$package, .is_installed, logical(1))
  to_install <- pkgs[missing_mask, , drop = FALSE]

  if (nrow(to_install) == 0) {
    cli::cli_alert_success(
      "All IsoformUniverse packages are already installed."
    )
    return(invisible(NULL))
  }

  cli::cli_h1("Installing IsoformUniverse packages")
  for (i in seq_len(nrow(to_install))) {
    .install_one(to_install[i, ], ...)
  }

  cli::cli_alert_success("Installation complete.")
  invisible(NULL)
}

#' Update IsoformUniverse packages
#'
#' Updates all packages listed in [isoformUniverse_packages()] to their latest
#' versions.  Unlike [isoformUniverse_install()], this function also updates
#' packages that are already installed.
#'
#' * **Bioconductor** packages are updated via
#'   [BiocManager::install()][BiocManager::install].
#' * **GitHub** packages are updated via
#'   [remotes::install_github()][remotes::install_github] with
#'   `upgrade = "always"`.
#'
#' @param ... Additional arguments passed to the underlying installer.
#'
#' @return Invisibly returns `NULL`.  The function is called for its
#'   side-effect of updating packages.
#' @export
#' @examples
#' \dontrun{
#' isoformUniverse_update()
#' }
isoformUniverse_update <- function(...) {
  pkgs <- isoformUniverse_packages()

  cli::cli_h1("Updating IsoformUniverse packages")
  for (i in seq_len(nrow(pkgs))) {
    .update_one(pkgs[i, ], ...)
  }

  cli::cli_alert_success("Update complete.")
  invisible(NULL)
}
