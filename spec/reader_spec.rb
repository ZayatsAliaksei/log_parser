# frozen_string_literal: true

require './lib/reader'

RSpec.describe Reader do
  let(:valid_file) { 'spec/files/valid.log' }
  let(:invalid_file) { 'spec/files/empty.txt' }
  let(:not_readable_file) { 'spec/files/qqq.zip' }
  let(:invalid_file_path) { 'a/b/c' }
  let(:reader) { described_class.new(valid_file) }
  let(:reader_invalid) { described_class.new(invalid_file_path) }
  let(:reader_empty) { described_class.new(invalid_file) }
  let(:not_reader) { described_class.new(not_readable_file) }

  describe 'initialize' do
    it 'initializes when path is given as an argument' do
      expect(reader.path).to eq(valid_file)
    end

    context 'with no logfile argument' do
      it 'should raise Argument error' do
        expect { described_class.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#valid?' do
    context 'when file is missing' do
      it 'should rise File not found' do
        expect { reader_invalid.valid? }.to raise_error('File not found')
      end
    end

    context 'when file is empty' do
      it 'should rise Expecting not empty file' do
        expect { reader_empty.valid? }.to raise_error('Expecting not empty file')
      end
    end
  end

  describe '#read' do
    context 'when output is a hash' do
      it 'returns hash' do
        expect(reader.read).to be_a(Hash)
      end
    end
  end
end
