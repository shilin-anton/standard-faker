require "test_helper"

class StandardFakerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Standard::Faker::VERSION
  end
end
