include CommandUnit

scenario :command_unit, 'Running command-unit tests and being concerned with the time they take' do

	when_i 'run one hundred scenarios' do |context|

		100.times do |n|
			scenario :timer_tests, 'a very repetetive scenario' do
				when_i "create the number #{n}" do |c|
					c[:key] = n
				end
				i_expect 'only even numbers' do |c|
					if c[:key] % 2 == 0
						pass
					else
						fail 'odd'
					end
				end
			end
		end

		context[:output] = run_silent :timer_tests
	end

	i_expect 'to see how long it took' do |context|
		if context[:output] =~ /^\s*Completed in [0-9]+\.[0-9]+s/m
			pass
		else
			fail "Could not find the timer output... Actual output was: \n=====\n#{context[:output]}\n=====\n"
		end
	end

end