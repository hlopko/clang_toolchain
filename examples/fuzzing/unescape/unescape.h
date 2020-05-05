#ifndef EXAMPLES_FUZZING_UNESCAPE_UNESCAPE_H
#define EXAMPLES_FUZZING_UNESCAPE_UNESCAPE_H

#include <string>
#include <string_view>

namespace fuzzing {

// Replaces any occurrence of C escape sequences with their equivalent
// character. Currently supports '\n', '\t' and '\\'. Invalid sequences are
// ignored.
std::string UnescapeString(std::string_view str);

}  // namespace fuzzing

#endif // EXAMPLES_FUZZING_UNESCAPE_UNESCAPE_H

