# Clang toolchain

Super experimental!

This is a somewhat naive attempt at writing a minimal yet useful clang C++
toolchain for Bazel.

To build examples, you only have to run:

```
bazel test //examples/fuzzing/unescape:unescape_test
```

To build the fuzzed test, run:

```
bazel build --config=fuzzer //examples/fuzzing/unescape:unescape_fuzzer
bazel-bin/examples/fuzzing/unescape/unescape_fuzzer
```

For hacking, be aware that there are default Bazel options specified in the
`.bazelrc`.
