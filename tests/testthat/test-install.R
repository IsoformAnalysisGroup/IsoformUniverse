test_that("isoformUniverse_install() returns NULL invisibly when all packages installed", {
  # Mock .is_installed to return TRUE for all packages
  local_mocked_bindings(
    .is_installed = function(pkg) TRUE,
    .package = "IsoformUniverse"
  )
  result <- isoformUniverse_install()
  expect_null(result)
})

test_that(".check_suggests() errors informatively when package is missing", {
  expect_error(
    IsoformUniverse:::.check_suggests("__not_a_real_package__"),
    regexp = "__not_a_real_package__"
  )
})

test_that(".check_suggests() returns silently when package is available", {
  expect_silent(IsoformUniverse:::.check_suggests("utils"))
})
