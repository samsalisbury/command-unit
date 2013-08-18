include CommandUnit

scenario :command_unit, 'Using expectation helpers' do
	
	when_i 'use the expect helper with a boolean true' do |context|
		context[:result] = expect true
	end

	i_expect 'to get a passing result' do |context|
		if not context[:result].is_a? ExpectationResult
			fail 'Expecting an ExpectationResult'
		elsif context[:result].success? != true
			fail 'Expecting a pass'
		else
			pass
		end
	end

	when_i 'use the expect helper with a boolean false' do |context|
		context[:result] = expect false
	end

	i_expect 'to get a failing result' do |context|
		if not context[:result].is_a? ExpectationResult
			fail 'Expecting an ExpectationResult'
		elsif context[:result].success? != false
			fail 'Expecting a pass'
		else
			pass
		end
	end

end