# Clang toolchain

Super experimental!

This is a somewhat naive attempt at writing a minimal yet useful clang C++
toolchain for Bazel. It hardcodes a lot (e.g. clang at /usr/bin/clang,
`cxx_builtin_include_directories` used for header validation are hardcoded to
various directories I found useful and you will likely need to change/add more).

To build fuzzing example, run:

```
bazel test //examples/fuzzing/unescape:unescape_test
```

To build the fuzzed test, run:

```
bazel build --config=fuzzer //examples/fuzzing/unescape:unescape_fuzzer
bazel-bin/examples/fuzzing/unescape/unescape_fuzzer
```

To build the layering-check violating example (and see it being busted):

```
bazel build //examples/layering_check:bin --features=layering_check
```

For hacking, be aware that there are default Bazel options specified in the
`.bazelrc`.
