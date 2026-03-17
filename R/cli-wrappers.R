# CLI wrapper helpers (to make messaging easy to mock in tests) ──────────────

.cli_h1 <- function(...) {
  cli::cli_h1(...)
}

.cli_bullets <- function(...) {
  cli::cli_bullets(...)
}

.cli_alert_info <- function(...) {
  cli::cli_alert_info(...)
}

.cli_alert_success <- function(...) {
  cli::cli_alert_success(...)
}

.cli_alert_warning <- function(...) {
  cli::cli_alert_warning(...)
}

.cli_alert_danger <- function(...) {
  cli::cli_alert_danger(...)
}
