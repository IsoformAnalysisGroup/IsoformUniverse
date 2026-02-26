test_that(".is_attached() returns FALSE for packages not on search path", {
  # A non-existent package should never be on the search path
  result <- IsoformUniverse:::.is_attached("__not_a_real_package__")
  expect_false(result)
})

test_that(".is_attached() returns TRUE for base", {
  # 'base' is always on the search path
  result <- IsoformUniverse:::.is_attached("base")
  expect_true(result)
})

test_that(".is_installed() returns FALSE for non-existent package", {
  result <- IsoformUniverse:::.is_installed("__not_a_real_package__")
  expect_false(result)
})

test_that(".is_installed() returns TRUE for base package", {
  result <- IsoformUniverse:::.is_installed("base")
  expect_true(result)
})

test_that("isoformUniverse_attach() returns invisibly", {
  # Should return without error; result is invisible character vector
  result <- isoformUniverse_attach()
  expect_type(result, "character")
})
