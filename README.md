# run_length_encoder

Run-length encode/decode stuff

## Installation

```rb
gem 'run_length_encoder'
```

## Usage

```rb
require 'run_length_encoder'

# Basic usage
# (see `RunLengthEncoder::Instance#initialize` for supported options)
rle = RunLengthEncoder.new
rle.encode("0000111010")
=> "4:0;3:1;1:0;1:1;1:0"

rle.decode("4:0;3:1;1:0;1:1;1:0")
=> "0000111010"

# You can use built-in configurations
rle = RunLengthEncoder.for_integer_array
rle.encode([0, 0, 0, 0, 1, 1, 1, 0, 1, 0])
=> "4:0;3:1;1:0;1:1;1:0"

rle.decode("4:0;3:1;1:0;1:1;1:0")
=> [0, 0, 0, 0, 1, 1, 1, 0, 1, 0]

# encode/decode are aliased to dump/load for integration with ActiveRecord::Serialization
```
