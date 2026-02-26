# IsoformUniverse (development version)

## Initial release

* Added `isoformUniverse_packages()` to list all member packages with their
  source and repository information.
* Added `isoformUniverse_attach()` to load all member packages; called
  automatically by `.onAttach` when running `library(IsoformUniverse)`.
* Added `isoformUniverse_install()` to install any missing member packages.
* Added `isoformUniverse_update()` to update all member packages to their
  latest versions.
* Initial member packages:
  * [pairedGSEA](https://bioconductor.org/packages/pairedGSEA/) (Bioconductor)
  * [IsoformSwitchAnalyzeR](https://github.com/kvittingsekse/IsoformSwitchAnalyzeR) (GitHub)
