# frozen_string_literal: true

require 'byebug'

class Reader
  PATH = /^(.*?)\s/.freeze
  IP = /\s(.*)/.freeze

  attr_reader :file, :path

  def initialize(path)
    @path = path
  end

  def valid?
    @file = File.open(@path)
    raise 'Expecting a readable file' unless File.readable?(@file)
    raise 'Expecting not empty file' if File.empty?(@file)
  rescue Errno::ENOENT
    raise 'File not found'
  end

  def read
    unless valid?
      data = Hash.new { |h, key| h[key] = [] }
      @file.map do |line|
        path = line[PATH].strip
        ip = line[IP].strip
        data[path] << ip
      end
      @file.close
      data  # {"/help_page/1"=>["126.318.035.038", "929.398.951.889"]}
    end
  end
end
