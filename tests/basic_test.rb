require File.dirname(__FILE__) + "/../lib/riconv"
require "test/unit"

class RiconvTest < Test::Unit::TestCase
  TEST_STRING = "Hallo Welt!.../"

  def test_encode_decode
    ite = Iconv.iconv("ISO-8859-1", "EBCDIC-DE", TEST_STRING)[0]
    assert_not_equal(TEST_STRING, ite)
    eti = Iconv.iconv("EBCDIC-DE", "ISO-8859-1", ite)[0]
    assert_equal(eti, TEST_STRING)
  end
end
