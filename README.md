# IsoformUniverse <img src="man/figures/logo.png" align="right" height="139" alt="" />

<!-- badges: start -->
<!-- badges: end -->

**IsoformUniverse** is an umbrella R package for isoform-level analysis —
inspired by how [`tidyverse`](https://www.tidyverse.org/) manages its
ecosystem.  A single call to `library(IsoformUniverse)` installs, loads, and
keeps in sync a curated set of isoform-analysis packages hosted on
Bioconductor and GitHub.

---

## Packages included

| Package | Source | Description |
|---------|--------|-------------|
| [pairedGSEA](https://bioconductor.org/packages/pairedGSEA/) | Bioconductor | Paired gene-set enrichment analysis for gene and isoform expression |
| [IsoformSwitchAnalyzeR](https://github.com/kvittingsekse/IsoformSwitchAnalyzeR) | GitHub | Identify, annotate, and visualise isoform switches with functional consequences |

---

## Installation

### Install IsoformUniverse

```r
# Install from GitHub
remotes::install_github("elena-iri/IsoformUniverse")
```

### Install all member packages

```r
library(IsoformUniverse)

# Install any missing member packages
isoformUniverse_install()
```

---

## Usage

```r
library(IsoformUniverse)
#> ── IsoformUniverse ─────────────────────────────────────────────────────────
#> ✔ pairedGSEA 1.4.0
#> ✔ IsoformSwitchAnalyzeR 2.4.0
```

### Update all member packages

```r
isoformUniverse_update()
```

### Inspect the package registry

```r
isoformUniverse_packages()
#>                  package        source                                repo
#> 1             pairedGSEA  Bioconductor                                <NA>
#> 2  IsoformSwitchAnalyzeR        GitHub  kvittingsekse/IsoformSwitchAnalyzeR
```

---

## Adding new packages

IsoformUniverse is designed to grow as the team develops more tools.  To add
a new package:

1. **Edit `R/packages.R`** — add a row to the `.isoformverse_pkgs` data frame:

   ```r
   .isoformverse_pkgs <- data.frame(
     package = c(
       "pairedGSEA",
       "IsoformSwitchAnalyzeR",
       "myNewPackage"          # ← add your package here
     ),
     source = c(
       "Bioconductor",
       "GitHub",
       "GitHub"                # ← "Bioconductor" or "GitHub"
     ),
     repo = c(
       NA_character_,
       "kvittingsekse/IsoformSwitchAnalyzeR",
       "myOrg/myNewPackage"    # ← "owner/repo", or NA for Bioconductor
     ),
     stringsAsFactors = FALSE
   )
   ```

2. **Regenerate documentation**:

   ```r
   devtools::document()
   ```

3. **Add a `NEWS.md` entry** describing the new package.

4. **Open a pull request** against `main`.

The install and update machinery will automatically pick up the new entry —
no other code changes are needed.

---

## Functions

| Function | Description |
|----------|-------------|
| `library(IsoformUniverse)` | Loads all member packages (calls `isoformUniverse_attach()` automatically) |
| `isoformUniverse_packages()` | Returns a data frame of all member packages and their sources |
| `isoformUniverse_install()` | Installs any missing member packages |
| `isoformUniverse_update()` | Updates all member packages to their latest versions |
| `isoformUniverse_attach()` | Attaches all member packages and prints a startup message |

---

## License

MIT © Elena Iri