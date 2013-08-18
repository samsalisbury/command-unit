require_relative '../string/console_colours'

module CommandUnit

  class Scenario
    def initialize(namespace, desc, out_stream, &block)
      @out_stream = out_stream
      @namespace = namespace
      @id = @@scenario_count += 1
      @desc = desc
      @block = block
      @set_up_block = nil
      @tests = []
      @current_test = nil
      @tear_down_block = nil
      @scenario_set_up_block = nil
      @scenario_tear_down_block = nil
      @tests_run = 0
      @expectations_run = 0
      @expectations_met = 0
      @expectations_not_met = 0
      @inconclusive_expectations = 0
    end

    def run(hooks, out_stream=@out_stream)
      raise "CommandUnit::Scenario.run hooks must be of type Hooks" unless hooks.is_a? Hooks
      hooks.fire(:before_scenario)
      scenario_failed = false
      out_stream.puts "\nRunning scenario #{@id}: #{@desc}"
      @@current_scenario = self
      @block.call
      context = {}
      @scenario_set_up_block.call(context) unless @scenario_set_up_block.nil?
      @tests.each do |test|
        hooks.fire(:before_test)
        test_failed = false
        out_stream.puts "\tWhen I #{test.when_i_text}"
        @tests_run += 1
        @set_up_block.call(context) unless @set_up_block.nil?
        test.when_i_block.call(context) unless test.when_i_block.nil?
        test.expectations.each do |expectation|
          hooks.fire :before_expectation
          out_stream.print "\t\tI expect #{expectation.desc}..."
          result = expectation.block.call(context)
          @expectations_run += 1
          if result.respond_to? :success?
            if result.success?
              hooks.fire :expectation_pass
              @expectations_met +=1
              out_stream.puts "Success! #{result.message}".console_green
            else
              hooks.fire :expectation_fail
              test_failed = true
              scenario_failed = true
              @expectations_not_met +=1
              out_stream.puts "Failure!".console_red
              out_stream.puts result.message
            end
          else
            test_failed = true
            @inconclusive_expectations += 1
            out_stream.puts "Inconclusive! #{result}".console_yellow
          end
          hooks.fire :after_expectation
        end
        if test_failed
          hooks.fire :test_fail
        else
          hooks.fire :test_pass
        end

        hooks.fire :after_test
        @tear_down_block.call(context) unless @tear_down_block.nil?
      end

      if scenario_failed
        hooks.fire :scenario_fail
      else
        hooks.fire :scenario_pass
      end

      hooks.fire :after_scenario
      @scenario_tear_down_block.call(context) unless @scenario_tear_down_block.nil?
      @@current_scenario = nil

      colour = @expectations_not_met == 0 ? String::CONSOLE_GREEN : String::CONSOLE_RED

      out_stream.puts "Scenario #{@id} finished, #{@tests_run} tests, #{@expectations_run} expectations with #{@expectations_met} successful and #{@expectations_not_met} failures.".console_colour(colour)
    end

    def run_silent(hooks)
      buffer = StringIO.new
      run(hooks, buffer)
      return buffer.string
    end

    def add_test(test)
      @tests.push test
      @current_test = test
    end

    attr_accessor :desc, :block, :set_up_block, :tests, :tear_down_block, :current_test,
                  :scenario_set_up_block, :scenario_tear_down_block, :namespace, :out
  end

end
