# frozen_string_literal: true

require 'rspec'
require './lib/sorter'

RSpec.describe Sorter do
  let(:data) do
    {
      "/help_page/1": ['126.318.035.038', '929.398.951.889', '722.247.931.582'],
      "/contact": ['184.123.665.067', '184.123.665.067', '543.910.244.929']
    }
  end
  let(:unsorted_data) do
    {
      '/help_page/1' => 80, '/contact' => 89, '/home' => 78, '/about/2' => 90, '/index' => 82, '/about' => 81
    }
  end
  let(:sorter) { described_class.new(data) }
  let(:value) { 'visits' }
  let(:arr) { [['/help_page/1', 80]] }

  describe 'initialize' do
    it 'initializes when path is given as an argument' do
      expect(sorter.data).to eq(data)
    end

    it 'should raise Argument error' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end

  describe '#hash_value_count' do
    it 'should count sum of each key values' do
      expect(sorter.hash_value_count(data)).to eq({ "/help_page/1": 3, "/contact": 3 })
    end
  end

  describe '#sorting,#unique_sorting,#visit_sorting,#all_sorting' do
    it 'should take hash and return and sorting string' do
      expect(sorter.sorting(unsorted_data, value)).to be_an_instance_of(String)
    end
  end

  describe '#sorting,#unique_sorting,#visit_sorting,#all_sorting' do
    it 'should take hash and return sorting string' do
      expect(sorter.sorting(data, value)).to eq('/contact 3-visits- /help_page/1 3-visits')
    end
  end

  describe '#hash_sorting_value' do
    it 'should return sorting most pages views to less page views' do
      expect(sorter.hash_sorting_value(unsorted_data)).to eq(
        [['/about/2', 90], ['/contact', 89], ['/index', 82], ['/about', 81], ['/help_page/1', 80], ['/home', 78]]
      )
    end
  end

  describe '#output_data' do
    it 'should return readable data' do
      content = sorter.output_data(arr, value)
      expect(content).to eq('/help_page/1 80-visits')
    end
  end
end
