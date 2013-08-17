require_relative '../lib/command-unit'

include CommandUnit

scenario :command_unit, 'Running a scenario with no tests or assertions' do

  when_i 'execute the scenario' do |context|
    context[:scenario] = scenario 'This is an empty scenario' do

    end
    context[:out] = capture_stdout do
      context[:scenario].run
    end
  end

  i_expect 'to see the scenario title' do |context|
    if context[:out].include? 'This is an empty scenario' then
      success
    else
      failure "Output was: '#{context[:out]}'"
    end
  end

end

run :command_unit