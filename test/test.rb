require_relative '../lib/command-unit'

require_relative 'scenarios/empty_scenario'
require_relative 'scenarios/one_test_one_passing_expectation'

scenario :command_unit, 'Running one namespaced scenario with one test with one passing expectation from CommandUnit::run' do

  set_up do
    scenario :group_1, 'This is the one scenario' do
      when_i 'this is the one test' do
        # Nowt ;)
      end
      i_expect 'this is the one expectation' do
        success
      end
    end
  end

  when_i 'run the one scenario' do |context|
    context[:out] = run_silent :group_1
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