cc_binary(
  name = "bin",
  deps = [
    ":lib",
    # Uncomment below to make the code layering check compliant.
    # ":base",
  ],
  srcs = ["bin.cc"],
)

cc_library(
  name = "lib",
  srcs = ["lib.cc"],
  hdrs = ["lib.h"],
  deps = [":base"],
)

cc_library(
  name = "base",
  hdrs = ["base.h"],
)
