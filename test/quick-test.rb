require_relative '../lib/command-unit'

include CommandUnit

scenario 'When blahblahs are whatnots' do

  scenario_set_up do |context|
    puts 'scenario_set_up called!'
  end

  scenario_tear_down do |context|
    puts 'scenario_tear_down called!'
  end

  set_up do |context|
    puts 'set_up called!'
    context[:thing] = 'some property set in set_up'
  end

  tear_down do |context|
    puts 'tear_down called!'
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

  when_i "create another test" do |context|
    # Doing nothing
    puts 'when_i called!'
    context[:thing2] = 'thing'
  end

  i_expect 'that the second test is also run' do |context|
    puts 'i_expect called!'
    context[:thing3] = 'thang'
  end

  when_i "create a third test with 2 expectations" do |context|
    # Doing nothing
    puts 'when_i called!'
    context[:thing2] = 'thing'
  end

  i_expect 'that both expectations are called' do |context|
    puts 'i_expect called!'
    context[:thing3] = 'thang'
  end

  i_expect 'that this second expectation will also be called!' do |context|
    puts 'i_expect called!'
    context[:thing3] = 'thang'
  end

end

run