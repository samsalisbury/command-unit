module CommandUnit
	class Totaliser
		def initialize
			@scenarios_run = 0
			@scenarios_passed = 0
			@scenarios_failed = 0
			@tests_run = 0
			@tests_passed = 0
			@tests_failed = 0
			@expectations_run = 0
			@expectations_passed = 0
			@expectations_failed = 0
		end

		def scenario_run
			@scenarios_run += 1
		end

		def scenario_pass
			@scenarios_passed += 1
		end

		def scenario_fail
			@scenarios_failed += 1
		end

		def test_run
			@tests_run += 1
		end

		def test_pass
			@tests_passed += 1
		end

		def test_fail
			@tests_failed += 1
		end

		def expectation_run
			@expectations_run += 1
		end

		def expectation_pass
			@expectations_passed += 1
		end

		def expectation_fail
			@expectations_failed += 1
		end

		attr_reader :scenarios_run, :scenarios_passed, :tests_run, :tests_passed,
		            :expecations_run, :expecations_passed
	end
end