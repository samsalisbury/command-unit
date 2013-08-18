require_relative '../lib/command-unit'

include CommandUnit

scenario :command_unit, 'Running a scenario with no tests or assertions' do

  when_i 'execute the scenario' do |context|
    context[:scenario] = scenario 'This is an empty scenario' do

    end
    context[:out] = context[:scenario].run_silent
  end

  i_expect 'to see the scenario title' do |context|
    if context[:out].include? 'This is an empty scenario'
      success
    else
      failure "Output was: '#{context[:out]}'"
    end
  end

end

scenario :command_unit, 'Running a scenario with 1 test and 1 passing assertion' do

  set_up do |context|
    context[:scenario] = scenario 'This scenario has 1 test with 1 assertion' do
      when_i 'have 1 test in the scenario' do
        # Empty test test ;)
      end
      i_expect 'that this should pass' do
        success
      end
    end
  end

  when_i 'run the scenario' do |context|
    context[:out] = context[:scenario].run_silent
  end

  i_expect 'to see the when_i text' do |context|
    if context[:out].include? 'have 1 test in the scenario'
      success
    else 
      failure
    end
  end

  i_expect 'to see the i_expect text' do |context|
    if context[:out].include? 'that this should pass'
      success
    else
      failure "\n\n=====\n\n#{context[:out]}\n\n=====\n\n"
    end
  end

  i_expect 'to see the correct number of tests and expectations reported' do |context|
    if context[:out].include? '1 tests, 1 expectations with 1 successful and 0 failures'
      success
    else
      failure
    end
  end

  i_expect 'to see the total number of run scenarios' do |context|
    if context[:out].include? 'Ran 1 scenario (1 tests, 1 expectation); All passed :)'
      success
    else
      failure
    end
  end

end

run :command_unit