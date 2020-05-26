def _env(ctx, name):
    if name not in ctx.os.environ:
        return None
    return ctx.os.environ[name]

def _find_clang(ctx):
    cc = _env(ctx, "CC") or "clang"
    if cc.startswith("/"):
        cc_path = cc
    elif "/" in cc:
        fail("Provide either absolute path or a binary name for CC.")
    else:
        cc_path = ctx.which(cc)
    if not cc_path:
        fail("'{}' binary not found on PATH".format(cc))
    return cc

def _to_llvm_prefix(ctx, path):
    bindir = ctx.execute(["dirname", path]).stdout.strip()
    return ctx.execute(["realpath", bindir + "/.."]).stdout.strip()

def _clang_configure_impl(ctx):
    cc = _find_clang(ctx)
    print("Using {} for clang".format(cc))
    llvm_prefix = _to_llvm_prefix(ctx, cc)
    print("Using {} for llvm prefix".format(llvm_prefix))
    ctx.template("toolchain/BUILD", ctx.attr._build_file, {"%{llvm_prefix}": llvm_prefix})
    ctx.symlink(ctx.attr._cc_toolchain_config, "toolchain/cc_toolchain_config.bzl")

clang_configure = repository_rule(
    implementation = _clang_configure_impl,
    configure = True,
    attrs = {
        "_build_file": attr.label(
            default = "//toolchain:BUILD.tpl",
            allow_single_file = True,
        ),
        "_cc_toolchain_config": attr.label(
            default = "//toolchain:cc_toolchain_config.bzl",
            allow_single_file = True,
        ),
    },
    environ = [
        "CC",
        "PATH",
    ],
)
