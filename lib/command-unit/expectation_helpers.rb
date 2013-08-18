module CommandUnit

	def pass(desc = '')
		ExpectationResult.new(desc, true)
	end

	def fail(desc = '')
		ExpectationResult.new(desc, false)
	end

	def expect(thing, &proc)
		if proc.nil?
			if thing == !!thing
				return ExpectationResult.new('', thing)
			else
				raise "CommandUnit::expect requires either true, false or any other value with a Proc"
			end
		end
		return ExpectationResult.new('', proc.call)
	end

end