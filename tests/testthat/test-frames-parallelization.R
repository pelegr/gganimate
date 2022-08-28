context("test-frames-parallelization")

test_that("frames parallelization with futures", {

  anim <- ggplot(airquality, aes(Day, Temp)) +
    geom_line(color = 'red', size = 1) +
    transition_time(Month)

  capture.output({
    future::plan("sequential")
    t0 <- system.time(out1 <- animate(anim, nframes = 1000))
    future::plan("multisession", workers = 4L)
    t1 <- system.time(out2 <- animate(anim, nframes = 1000))
  })

  print(t0)
  print(t1)
  expect_true(t0[[3]][1] > t1[[3]][1])

})
