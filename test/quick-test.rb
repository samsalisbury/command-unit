require_relative '../lib/command-unit'

include CommandUnit

scenario 'When blahblahs are whatnots' do

  set_up do |context|
    puts 'set_up called!'
    context[:thing] = 'some property set in set_up'
  end

  when_i "don't do anything" do |context|
    # Doing nothing
    puts 'when_i called!'
    context[:thing2] = 'thing'
  end

  i_expect 'to see a nice success message' do |context|
    puts 'i_expect called!'
    context[:thing3] = 'thang'
  end

end

run