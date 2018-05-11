RSpec.describe RunLengthEncoder do
  describe 'dump' do
    it 'serializes the string' do
      rle = RunLengthEncoder.new
      expect(rle.dump("0000111010")).to eq("4:0;3:1;1:0;1:1;1:0")
    end

    it 'serializes the array' do
      rle = RunLengthEncoder.new
      expect(rle.dump([0, 0, 0, 0, 1, 1, 1, 0, 1, 0])).to eq("4:0;3:1;1:0;1:1;1:0")
    end
  end

  describe 'load' do
    it 'deserializes the string' do
      rle = RunLengthEncoder.new
      expect(rle.load("4:0;3:1;1:0;1:1;1:0")).to eq("0000111010")
      expect(rle.load("")).to eq("")
    end

    it 'can deserialize to an array' do
      converter = proc do |splits|
        splits.reduce([]) do |acc, (count, n)|
          acc + count.times.map { n.to_i }
        end
      end
      rle = RunLengthEncoder.new(converter: converter)
      expect(rle.load("4:0;3:1;1:0;1:1;1:0")).to eq([0, 0, 0, 0, 1, 1, 1, 0, 1, 0])
      expect(rle.load("")).to eq([])
    end
  end

  it 'can change the term separator' do
    rle = RunLengthEncoder.new(term_separator: "|")
    expect(rle.dump("12")).to eq("1:1|1:2")
    expect(rle.load("1:1|1:2")).to eq("12")
  end

  it 'can change the count separator' do
    rle = RunLengthEncoder.new(count_separator: "|")
    expect(rle.dump("12")).to eq("1|1;1|2")
    expect(rle.load("1|1;1|2")).to eq("12")
  end

  it 'has a built-in :integer_array config' do
    rle = RunLengthEncoder.for_integer_array
    expect(rle.dump([0, 0, 0, 0, 1, 1, 1, 0, 1, 0])).to eq("4:0;3:1;1:0;1:1;1:0")
    expect(rle.load("4:0;3:1;1:0;1:1;1:0")).to eq([0, 0, 0, 0, 1, 1, 1, 0, 1, 0])
  end
end
