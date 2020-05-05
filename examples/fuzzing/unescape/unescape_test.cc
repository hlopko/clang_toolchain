#include "examples/fuzzing/unescape/unescape.h"

#include "gtest/gtest.h"

namespace fuzzing {

namespace {

TEST(UnescapeStringTest, HandlesEmptyString) {
  EXPECT_EQ(UnescapeString(""), "");
}

TEST(UnescapeStringTest, PlainStringIsReturnedAsIs) {
  EXPECT_EQ(UnescapeString("plain text"), "plain text");
}

TEST(UnescapeStringTest, EscapeSequencesAreUnescaped) {
  EXPECT_EQ(UnescapeString("two\\nlines"), "two\nlines");
  EXPECT_EQ(UnescapeString("back\\\\slash"), "back\\slash");
}

}  // namespace

}  // namespace fuzzing
