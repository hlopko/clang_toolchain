#include "examples/fuzzing/unescape/unescape.h"

#include <cstddef>
#include <string>

namespace fuzzing {

std::string UnescapeString(std::string_view str) {
  std::string result;
  for (size_t i = 0; i < str.size(); ++i) {
    if (str[i] == '\\') {
      ++i;
      switch (str[i]) {
        case 'n':
          result.push_back('\n');
          break;
        case 't':
          result.push_back('\t');
          break;
        case '\\':
          result.push_back('\\');
          break;
        default:
          break;
      }
    } else {
      result.push_back(str[i]);
    }
  }
  return result;
}

}  // namespace fuzzing

