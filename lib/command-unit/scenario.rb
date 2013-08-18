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

    def run(out_stream=@out_stream)
      out_stream.puts "\nRunning scenario #{@id}: #{@desc}"
      @@current_scenario = self
      @block.call
      context = {}
      @scenario_set_up_block.call(context) unless @scenario_set_up_block.nil?
      @tests.each do |test|
        out_stream.puts "\tWhen I #{test.when_i_text}"
        @tests_run += 1
        @set_up_block.call(context) unless @set_up_block.nil?
        test.when_i_block.call(context) unless test.when_i_block.nil?
        test.expectations.each do |expectation|
          out_stream.print "\t\tI expect #{expectation.desc}..."
          result = expectation.block.call(context)
          @expectations_run += 1
          if result.respond_to? :success?
            if result.success?
              @expectations_met +=1
              out_stream.puts "Success! #{result.message}".console_green
            else
              @expectations_not_met +=1
              out_stream.puts "Failure! #{result.message}".console_red
            end
          else
            @inconclusive_expectations += 1
            out_stream.puts "Inconclusive! #{result}".console_yellow
          end
        end
        @tear_down_block.call(context) unless @tear_down_block.nil?
      end
      @scenario_tear_down_block.call(context) unless @scenario_tear_down_block.nil?
      @@current_scenario = nil

      colour = @expectations_not_met == 0 ? String::CONSOLE_GREEN : String::CONSOLE_RED

      out_stream.puts "Scenario #{@id} finished, #{@tests_run} tests, #{@expectations_run} expectations with #{@expectations_met} successful and #{@expectations_not_met} failures.".console_colour(colour)
    end

    def run_silent
      buffer = StringIO.new
      run(buffer)
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
