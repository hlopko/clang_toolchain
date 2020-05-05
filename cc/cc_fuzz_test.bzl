# Copyright 2020 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""cc_fuzz_test is just like a cc_test, except that it takes main() from the
external fuzzing engine.

Which fuzzing engine is used is determined by Bazel command line flags.

Currently supported engines:
  * libfuzzer
"""

def cc_fuzz_test(
        fuzzing_dict = None,
        corpus = None,
        corpus_cns = None,
        data = [],
        deps = [],
        tags = [],
        parsers = None,
        hotlists = None,
        **kwargs):
    """Specify how your fuzz target is built. See go/getstartedfuzzing#build-rule.

    Args:
      fuzzing_dict: An optional a set of dictionary files following
        the AFL/libFuzzer dictionary syntax. See go/fuzzing-codelab#dictionary.

      corpus: An optional set of files used as the initial test corpus
        for the target. When doing "blaze test" in the default null-fuzzer
        (unittest) mode, these files are automatically passed to the target function.
        See go/testcorpus#corpus_attribute.

      corpus_cns: An optional list of cns paths that point to ear files
        containing test inputs. See go/testcorpus#corpus_cns.

      data: Additional data dependencies passed to the underlying cc_test rule.

      deps: An optional list of dependencies for the code you're fuzzing.

      tags: Additional tags passed to the underlying cc_test rule.

      parsers: An optional list of file extensions that the target supports.

      **kwargs: Collects all remaining arguments and passes them to the underlying
        cc_test rule generated by the macro.
    """

    # isinstance() is not permitted in BUILD extensions.
    int_type = type(1)
    string_type = type("string")
    list_type = type(["list"])

    corpus = corpus or []
    if type(corpus) != list_type:
        fail("corpus should be a list, but was " + type(corpus))

    parsers = parsers or []
    if type(parsers) != list_type:
        fail("parsers should be a list, but was " + type(parsers))
    if any([type(parser) != string_type for parser in parsers]):
        fail("parsers should be a list of strings")

    fuzzing_dict = fuzzing_dict or []
    if type(fuzzing_dict) != list_type:
        fail("fuzzing_dict should be a list, but was " + type(fuzzing_dict))
    if any([type(dictionary) != string_type for dictionary in fuzzing_dict]):
        fail("fuzzing_dict should be a list of strings")

    # cc_fuzz_tags = fuzz_tags(
    #     fuzzing_dict,
    #     corpus,
    #     corpus_cns,
    #     tags,
    #     parsers,
    #     hotlists,
    # )

    native.cc_test(
        deps = deps,
        data = data + fuzzing_dict + corpus,
        stamp = 0,
        linkstatic = 1,
        **kwargs
    )
