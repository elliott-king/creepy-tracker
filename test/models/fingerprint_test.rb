require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase

  strings = [
    ['wikimedia', 'wikimania'],
    [' abcd', 'abcd abcd'],
    ['diet', 'tide'],
    ['', ''],
    ['abcd', 'abcd'],
    ['abcd', 'efgh'],
  ]

  test "longest substring" do
    assert_equal [0,0,5], Fingerprint.longest_match(strings[0][0], strings[0][1])
    assert_equal [0,4,5], Fingerprint.longest_match(strings[1][0], strings[1][1])
    assert_equal [4,0,5], Fingerprint.longest_match(strings[1][1], strings[1][0])
    assert_equal [0,2,1], Fingerprint.longest_match(strings[2][0], strings[2][1])
    assert_equal [0,3,1], Fingerprint.longest_match(strings[2][1], strings[2][0])
    assert_equal [0,0,0], Fingerprint.longest_match(strings[3][0], strings[3][1])
    assert_equal [0,0,4], Fingerprint.longest_match(strings[4][0], strings[4][1])
    assert_equal [0,0,0], Fingerprint.longest_match(strings[5][0], strings[5][1])
  end

  test "matching blocks" do
    assert_equal [[0,0,5],[7,7,2]], Fingerprint.matching_blocks(strings[0][0], strings[0][1])
    assert_equal [[0,4,5]], Fingerprint.matching_blocks(strings[1][0], strings[1][1])
    assert_equal [[4,0,5]], Fingerprint.matching_blocks(strings[1][1], strings[1][0])
    assert_equal [[0,3,1]], Fingerprint.matching_blocks(strings[2][1], strings[2][0])
    assert_equal [[0,2,1],[2,3,1]], Fingerprint.matching_blocks(strings[2][0], strings[2][1])
    assert_equal [], Fingerprint.matching_blocks(strings[3][0], strings[3][1])
    assert_equal [[0,0,4]], Fingerprint.matching_blocks(strings[4][1], strings[4][0])
    assert_equal [], Fingerprint.matching_blocks(strings[5][0], strings[5][1])
  end

  test 'ratio' do
    assert_equal (14.0/18.0), Fingerprint.ratio(strings[0][0], strings[0][1])
    assert_equal (10.0/14.0), Fingerprint.ratio(strings[1][0], strings[1][1])
    assert_equal (4.0/8.0), Fingerprint.ratio(strings[2][0], strings[2][1])
    assert_equal (2.0/8.0), Fingerprint.ratio(strings[2][1], strings[2][0])
    assert_equal (1.0), Fingerprint.ratio(strings[3][1], strings[3][0])
    assert_equal (1.0), Fingerprint.ratio(strings[4][1], strings[4][0])
    assert_equal (0.0), Fingerprint.ratio(strings[5][1], strings[5][0])
  end
end
