require './lib/parser.rb'

describe '#hello' do
  it 'greets the world' do
    parser = Parser.new
    expect(parser.hello).to eq "Hello! I'm Ruby!"
  end
end