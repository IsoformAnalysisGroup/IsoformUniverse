# Internal helpers for attaching (loading) packages ──────────────────────────

# Returns TRUE for each package that is already on the search path.
.is_attached <- function(pkgs) {
  paste0("package:", pkgs) %in% search()
}

# Try to attach a single package; returns TRUE on success, FALSE on failure.
.try_attach <- function(pkg) {
  tryCatch(
    {
      library(pkg, character.only = TRUE, warn.conflicts = FALSE)
      TRUE
    },
    error = function(e) FALSE
  )
}

# Print a startup message summarising what was attached / what failed.
.msg_attach <- function(pkgs, results) {
  ok  <- pkgs[results]
  bad <- pkgs[!results]

  if (length(ok) > 0) {
    versions <- vapply(ok, function(p) {
      tryCatch(
        as.character(utils::packageVersion(p)),
        error = function(e) "?"
      )
    }, character(1))
    bullets <- paste0(ok, " ", versions)
    names(bullets) <- rep("v", length(bullets))
    .cli_h1("IsoformUniverse")
    .cli_bullets(bullets)
  }

  if (length(bad) > 0) {
    not_installed <- bad[!vapply(bad, .is_installed, logical(1))]
    if (length(not_installed) > 0) {
      .cli_alert_warning(
        "The following package{?s} {?is/are} not installed and could not be \\
         loaded: {.pkg {not_installed}}.  \\
         Run {.code isoformUniverse_install()} to install them."
      )
    } else {
      .cli_alert_danger(
        "Failed to load: {.pkg {bad}}"
      )
    }
  }
}

# Returns TRUE if a package is installed (regardless of whether it is loaded).
.is_installed <- function(pkg) {
  nzchar(system.file(package = pkg))
}

# Public API ──────────────────────────────────────────────────────────────────

#' Attach all IsoformUniverse packages
#'
#' Loads every package listed in [isoformUniverse_packages()] and prints a
#' startup message that shows which packages were successfully attached and
#' their versions.  Packages that are already attached are silently skipped.
#'
#' This function is called automatically when you run
#' `library(IsoformUniverse)`.
#'
#' @return Invisibly returns a character vector of the names of all
#'   IsoformUniverse packages (whether or not they were successfully attached).
#' @export
#' @examples
#' \dontrun{
#' isoformUniverse_attach()
#' }
isoformUniverse_attach <- function() {
  pkgs <- isoformUniverse_packages()$package

  already <- .is_attached(pkgs)
  to_load <- pkgs[!already]

  if (length(to_load) == 0) {
    return(invisible(pkgs))
  }

  results <- vapply(to_load, .try_attach, logical(1))
  .msg_attach(to_load, results)

  invisible(pkgs)
}
