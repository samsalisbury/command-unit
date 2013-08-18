require_relative 'totaliser'

module CommandUnit

	class Hooks

		def initialize
			@before_scenario = []
			@scenario_pass = []
			@scenario_fail = []
			@after_scenario = []
			@before_test = []
			@test_pass = []
			@test_fail = []
			@after_test = []
			@before_expectation = []
			@expectation_pass = []
			@expectation_fail = []
			@after_expectation = []
			# Note: I know this is a smell, just trying to get tests passing...
			# Looks ripe for inheriting the hooks, and passing in a composition
			# of all hooks to the test runner...
			@totaliser = Totaliser.new
			add :before_scenario do totaliser.scenario_run end
			add :scenario_pass do totaliser.scenario_pass end
			add :scenario_fail do totaliser.scenario_fail end
			add :before_test do totaliser.test_run end
			add :test_pass do totaliser.test_pass end
			add :test_fail do totaliser.test_fail end
			add :before_expectation do totaliser.expectation_run end
			add :expectation_pass do totaliser.expectation_pass end
			add :expectation_fail do totaliser.expectation_fail end
		end

		attr_reader :totaliser,
		            :before_scenario, :scenario_pass, :scenario_fail, :after_scenario,
		            :before_test, :test_pass, :test_fail, :after_test,
		            :before_expectation, :expectation_pass, :expectation_fail, :after_expectation

		def add(event_name, &handler)
			raise "CommandUnit::Hooks.add No such event '#{event_name}'" unless self.respond_to? event_name
			handlers = instance_variable_get "@#{event_name}"
			handlers.push handler
		end

		def fire(event_name)
			raise "CommandUnit::Hooks.fire No such event '#{event_name}'" unless self.respond_to? event_name
			handlers = instance_variable_get "@#{event_name}"
			handlers.each do |handler|
				handler.call
			end
		end

	end

end