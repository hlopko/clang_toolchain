#include "examples/fuzzing/unescape/unescape.h"

using ::fuzzing::UnescapeString;

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
  std::string_view str(reinterpret_cast<const char *>(data), size);
  UnescapeString(str);
  return 0;
}
