# FixtureParts
FixtureParts registers data in DB for each test.

## Usage
How to use my plugin.

```ruby
class HogeTest < ActiveSupport::TestCase
  # File specification
  test "hoge_count" do
    FixtureParts.load("test/fixture_parts/hoge_test/hoges.yml")
    assert_equal(1, Hoge.all.count)
  end

  # Directory specification
  test "hoge_fuga_count" do
    FixtureParts.load_dir("test/fixture_parts/hoges_test")
    assert_equal(1, Hoge.all.count)
    assert_equal(1, Fuga.all.count)
  end

  # no validation
  test "hoge_count" do
    FixtureParts.load("test/fixture_parts/hoges_test_invalid/hoges.yml", valid: false)
  end
end
```

hoges.yml
```yml
one:
  id: 1
  integer: 1
  string: one
  boolean: true
  date: 2019-04-12
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'fixture_parts'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install fixture_parts
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
