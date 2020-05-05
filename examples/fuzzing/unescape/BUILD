# The `unescape` library example that we'll use to explore libfuzzing.

load("//cc:cc_fuzz_test.bzl", "cc_fuzz_test")

cc_library(
    name = "unescape",
    srcs = ["unescape.cc"],
    hdrs = ["unescape.h"],
)

cc_test(
    name = "unescape_test",
    srcs = ["unescape_test.cc"],
    deps = [
        ":unescape",
        "@com_google_googletest//:gtest",
        "@com_google_googletest//:gtest_main",
    ],
)

cc_fuzz_test(
    name = "unescape_fuzzer",
    srcs = ["unescape_fuzzer.cc"],
    deps = [":unescape"],
)
