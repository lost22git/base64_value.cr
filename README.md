# base64_value

Lazy Base64Value wrapper ported from [Helidon Base64Value](https://github.com/helidon-io/helidon/blob/main/common/common/src/main/java/io/helidon/common/Base64Value.java)

[API DOC](https://lost22git.github.io/base64_value.cr)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     base64_value:
       github: lost22git/base64_value.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "base64_value"

base64_value = Base64Value.parse "Y3J5c3RhbA=="

# or
# base64_value = Base64Value.from_bytes UInt8.static_array(99, 114, 121, 115, 116, 97, 108).to_slice

# or
# base64_value = Base64Value.from_plain "crystal"

puts base64_value.to_s # => "Y3J5c3RhbA=="
puts base64_value.to_bytes # => Bytes[99, 114, 121, 115, 116, 97, 108]
puts base64_value.to_plain # => crystal

```

## Development

### Run tests

```
crystal spec --progress
```

## Contributing

1. Fork it (<https://github.com/lost22git/base64_value.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [lost](https://github.com/your-github-user) - creator and maintainer
