include CommandUnit

scenario :command_unit, 'Running a scenario with 1 test and 1 failing assertion from CommandUnit::run' do

  set_up do
    scenario :group_1, 'This is the one scenario' do
      when_i 'this is the one test' do
        # Nowt ;)
      end
      i_expect 'this is the one expectation' do
        fail
      end
    end
  end

  when_i 'run the one scenario' do |context|
    context[:out] = run_silent :group_1
  end

  i_expect 'to see the when_i text' do |context|
    if context[:out].include? 'this is the one test'
      pass
    else 
      fail
    end
  end

  i_expect 'to see the i_expect text' do |context|
    if context[:out].include? 'this is the one expectation'
      pass
    else
      fail "\n\n=====\n\n#{context[:out]}\n\n=====\n\n"
    end
  end

  i_expect 'to see the correct number of tests and expectations of the scenario reported' do |context|
    if context[:out].include? '1 tests, 1 expectations with 0 successful and 1 failures'
      pass
    else
      fail
    end
  end

  i_expect 'to see the total number of run scenarios and totals' do |context|
    if context[:out].include? 'Ran 1 scenario, 1 failed (tests passed: 0, failed 1) (expectations passed: 0, failed 1)'
      pass
    else
      fail
    end
  end

end