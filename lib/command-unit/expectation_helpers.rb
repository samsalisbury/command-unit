module CommandUnit

	def pass(desc = '')
		ExpectationResult.new(desc, true)
	end

	def fail(desc = '')
		ExpectationResult.new(desc, false)
	end

	def expect(thing, &proc)
		if proc.nil?
			if thing == true
				return ExpectationResult.new('', true)
			elsif thing == false
				return ExpectationResult.new('Expected true but was false.', false)
			else
				raise "CommandUnit::expect requires either true, false or any other value with a Proc"
			end
		end

		result = proc.call(thing)
		if result.is_a? Array
			return ExpectationResult.new(result[1], result[0])
		else
			return ExpectationResult.new('', result)	
		end
	end

	def is_equal_to(this_thing)
		return Proc.new do |other_thing|
			if other_thing == this_thing
				true
			else
				[false, "Expecting exactly '#{this_thing}', but got '#{other_thing}'"]
			end
		end
	end

end