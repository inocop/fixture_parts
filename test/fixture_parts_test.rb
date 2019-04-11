require 'test_helper'

class FixtureParts::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, FixtureParts
  end

  test "load_yml" do
    FixtureParts.load("test/fixture_parts/hoge_test/hoges.yml")

    hoge_1 = Hoge.find(1)
    assert_equal("one", hoge_1.string)
    assert(2, Hoge.all.count)
  end

  test "load_dir" do
    FixtureParts.load_dir("test/fixture_parts/hoge_test")

    hoge_1 = Hoge.find(1)
    assert_equal("one", hoge_1.string)
    assert(2, Hoge.all.count)

    fuga_1 = Fuga.find(1)
    assert_equal("fuga_one", fuga_1.name)
    assert(2, Fuga.all.count)
  end

  test "load_invalid_yml" do
    FixtureParts.load("test/fixture_parts/hoge_test_invalid/hoges.yml", valid: false)

    hoge_1 = Hoge.find(1)
    assert_not(hoge_1.string)
  end

  test "load_invalid_yml_raise" do
    assert_raise(ActiveRecord::RecordInvalid) do
      $stdout = open('/dev/null', 'w')
      FixtureParts.load("test/fixture_parts/hoge_test_invalid/hoges.yml")
      $stdout=STDOUT
    end
  end
end
