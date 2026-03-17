# Test suite guide

This folder contains `testthat` tests for package internals and public API.

## Who uses these tests?

- **Package maintainers/contributors** run these tests before opening pull requests.
- **CI pipelines** run the same tests automatically on each commit.
- **Reviewers** use failures to identify regressions in package behavior.

## Test files

### `tests/testthat/test-packages.R`

Purpose: validate the package registry returned by `isoformUniverse_packages()`.

Expected behavior:
- returns a `data.frame`
- contains required columns (`package`, `source`, `repo`, `deps`)
- includes expected package names
- uses valid `source` values
- enforces `repo` formatting rules for GitHub entries and `NA` for Bioconductor
- has unique package names
- keeps `deps` as a list-column of data frames with required columns

Who benefits: contributors editing `R/packages.R`.

### `tests/testthat/test-attach.R`

Purpose: validate attach/load helper behavior.

Expected behavior:
- `.is_attached()` correctly detects package search-path presence
- `.is_installed()` correctly detects installation status
- `isoformUniverse_attach()` returns a character vector invisibly without error

Who benefits: contributors changing attach/startup behavior (`R/attach.R`, `R/zzz.R`).

### `tests/testthat/test-install.R`

Purpose: validate install/update workflows and status messaging.

Expected behavior:
- install returns invisibly when nothing needs installation
- helper checks fail with informative errors when required helpers are missing
- unknown package sources are handled gracefully
- update reports:
  - "up to date" when no package changed
  - "complete" when at least one package changed

Who benefits: contributors changing install/update logic (`R/install.R`).

## Why the install tests were failing

The failing tests attempted to mock `cli` functions directly inside the `cli`
namespace (`asNamespace("cli")`). In some environments, those specific bindings
are not mockable the way the tests expect, producing:

- `Can't find binding for cli_h1, cli_alert_info, cli_alert_success, cli_alert_warning`

The fix in this branch introduces package-local wrapper functions (`.cli_*`) and
updates `test-install.R` to mock those wrappers in the `IsoformUniverse`
namespace instead. This keeps behavior unchanged for users, while making tests
robust across environments.
