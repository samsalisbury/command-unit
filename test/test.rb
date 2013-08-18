require_relative '../lib/command-unit'

include CommandUnit

Dir[File.dirname(__FILE__) + '/scenarios/*.rb'].each do |file|
  require File.expand_path(file)
end

run :command_unit