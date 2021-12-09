# frozen_string_literal: true

require_relative 'lib/reader'
require_relative 'lib/sorter'

if ARGV.empty?
  puts 'Plz write file path and command "unique" or "visits" or "all"'
  exit
end

log_path = ARGV[0]
data = Reader.new(log_path).read
if ARGV[1] == 'unique'
  Sorter.new(data).unique_sorting(ARGV[1])
elsif ARGV[1] == 'visits'
  Sorter.new(data).visit_sorting(ARGV[1])
elsif ARGV.include?('all')
  Sorter.new(data).all_sorting
else
  puts 'input correct command with unique or visits or all statement'
end
