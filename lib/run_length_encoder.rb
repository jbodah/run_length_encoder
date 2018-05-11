require "run_length_encoder/version"

module RunLengthEncoder
  def self.new(opts = {})
    Instance.new(opts)
  end

  def self.for_integer_array(opts = {})
    default_opts = {
      converter: RunLengthEncoder::Converters.method(:integer_array)
    }
    Instance.new(default_opts.merge(opts))
  end

  module Converters
    def self.integer_array(splits)
      splits.reduce([]) do |acc, (count, n)|
        acc + count.times.map { n.to_i }
      end
    end
  end

  class Instance
    def initialize(count_separator: ":", term_separator: ";", converter: default_converter)
      @count_separator = count_separator
      @term_separator = term_separator
      @converter = converter
    end

    def encode(string_or_array)
      case string_or_array
      when String
        _encode(string_or_array.each_char)
      when Array
        _encode(string_or_array.each)
      else
        raise "Unsupported type: #{string_or_array.class}"
      end
    end
    alias :dump :encode

    def decode(encoded)
      terms = encoded.split(@term_separator)
      splits = terms.map { |term| term.split(@count_separator) }
      splits2 = splits.map { |(count, char)| [count.to_i, char] }
      @converter[splits2]
    end
    alias :load :decode

    private

    def _encode(enum)
      acc = []
      curr = nil
      count = 0
      flush = proc { |count, curr| acc << "#{count}#{@count_separator}#{curr}" if count > 0 }
      enum.each do |el|
        if el == curr
          count += 1
        else
          flush[count, curr]
          curr = el
          count = 1
        end
      end
      flush[count, curr]
      acc.join(@term_separator)
    end

    def default_converter
      proc { |splits| splits.reduce("") { |acc, (count, char)| acc << char * count }}
    end
  end
end
