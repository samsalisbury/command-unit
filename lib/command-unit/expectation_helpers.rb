module CommandUnit

	def pass(desc = '')
		ExpectationResult.new(desc, true)
	end

	def fail(desc = '')
		ExpectationResult.new(desc, false)
	end

end