module CommandUnit

	def pass(desc = '')
		ExpectationResult.new(desc, true)
	end

	def fail(desc = '')
		ExpectationResult.new(desc, false)
	end

	def expect(thing)
		return ExpectationResult.new('', thing)
	end

end