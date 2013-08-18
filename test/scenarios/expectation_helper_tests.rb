include CommandUnit

def expect_passing(result)
	if not result.is_a? ExpectationResult
		fail 'Expecting an ExpectationResult'
	elsif result.success? != true
		fail 'Expecting a pass'
	else
		pass
	end
end

def expect_failing(result)
	if not result.is_a? ExpectationResult
		fail 'Expecting an ExpectationResult'
	elsif result.success? != false
		fail 'Expecting a failure'
	else
		pass
	end
end

scenario :command_unit, 'Using expectation helpers' do
	
	when_i 'use the expect helper with a boolean true' do |context|
		context[:result] = expect true
	end

	i_expect 'to get a passing result' do |context|
		expect_passing context[:result]
	end

	when_i 'use the expect helper with a boolean false' do |context|
		context[:result] = expect false
	end

	i_expect 'to get a failing result' do |context|
		expect_failing context[:result]
	end

	when_i 'use the expect helper with a value and a Proc returning true' do |context|
		context[:result] = expect 'anything' do
			true
		end
	end

	i_expect 'to get a passing result' do |context|
		expect_passing context[:result]
	end

	when_i 'use the expect helper with a value and a Proc returning false' do |context|
		context[:result] = expect 'anything' do
			false
		end
	end

	i_expect 'to get a failing result' do |context|
		expect_failing context[:result]
	end

	when_i 'use the expect helper with is_equal_to and the things are equal' do |context|
		context[:result] = expect(123, &is_equal_to(123))
	end

	i_expect 'to get a passing result' do |context|
		expect_passing context[:result]
	end

	when_i 'use the expect helper with is_equal_to and the things are not equal' do |context|
		context[:result] = expect('my random string', &is_equal_to('my unequal string'))
	end

	i_expect 'to get a failing result' do |context|
		expect_failing context[:result]
	end

end