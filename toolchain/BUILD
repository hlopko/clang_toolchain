load(":cc_toolchain_config.bzl", "cc_toolchain_config")

cc_library(
    name = "malloc",
)

filegroup(
    name = "empty",
    srcs = [],
)

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8": ":cc-compiler-k8",
    },
)

cc_toolchain(
    name = "cc-compiler-k8",
    all_files = ":empty",
    ar_files = ":empty",
    as_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 1,
    toolchain_config = ":local",
    toolchain_identifier = "local",
    module_map = "@system_module_map//:module.modulemap",
)

cc_toolchain_config(
    name = "local",
)
