require_relative 'phonetic'
require 'test/unit'

class PhoneticTest < Test::Unit::TestCase

  def test_rit_to_phonetic
    assert_equal 'ROMEO INDIA TANGO', Phonetic.to_phonetic('RIT')
  end

  def test_ab_to_phonetic
    assert_equal 'ALPHA BRAVO', Phonetic.to_phonetic('AB')
  end

  def test_a_to_phonetic_lowercase
    assert_equal 'ALPHA', Phonetic.to_phonetic('a')
  end

  def test_line_rit_to_phonetic
    assert_equal 'ROMEO INDIA TANGO', Phonetic.translate('A2P RIT')
  end

  def test_line_phonetic_to_rit
    assert_equal 'RIT', Phonetic.translate('P2A ROMEO INDIA TANGO')
  end

  def test_phonetic_to_rit
    assert_equal 'RIT', Phonetic.from_phonetic('ROMEO INDIA TANGO')
  end

  def test_phonetic_to_ab
    assert_equal 'AB', Phonetic.from_phonetic('ALPHA BRAVO')
  end

  def test_phonetic_to_a_lowercase
    assert_equal 'A', Phonetic.from_phonetic('alpha')
  end

end
