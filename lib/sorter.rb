class Sorter

  ALL = %w(unique visits)

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def unique_sorting(value)
    h2 = Hash.new
    data.each {|k, v| h2[k] = (v|v)}
    sorting(h2,value)
  end

  def visit_sorting(value)
    sorting(data,value)
  end

  def sorting(hash,value)
    visits = hash_value_count(hash)
    sorted = hash_sorting_value(visits)
    output_data(sorted, value)
  end

  def all_sorting
    unique_sorting(ALL[0])
    visit_sorting(ALL[1])
  end

  def hash_value_count(hash)
    hash.merge(hash) { |*_, a| a.size }
  end

  def hash_sorting_value(hash)
    hash.sort_by {|k,v| v}.reverse
  end

  def output_data(arr, param)
    arr.map! { |v|  p "#{v[0]} #{v[1]}-#{param}" }.join('- ')
  end

end