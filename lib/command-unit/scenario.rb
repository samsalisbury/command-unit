module CommandUnit

  class Scenario
    def initialize(namespace, desc, &block)
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

    def run
      puts "\nRunning scenario #{@id}: #{@desc}"
      @@current_scenario = self
      @block.call
      context = {}
      @scenario_set_up_block.call(context) unless @scenario_set_up_block.nil?
      @tests.each do |test|
        puts "\tWhen I #{test.when_i_text}"
        @tests_run += 1
        @set_up_block.call(context) unless @set_up_block.nil?
        test.when_i_block.call(context) unless test.when_i_block.nil?
        test.expectations.each do |expectation|
          print "\t\tI expect #{expectation.desc}..."
          result = expectation.block.call(context)
          @expectations_run += 1
          if result.respond_to? :success?
            if result.success?
              @expectations_met +=1
              puts "Success! #{result.message}"
            else
              @expectations_not_met +=1
              puts "Failure! #{result.message}"
            end
          else
            @inconclusive_expectations += 1
            puts "Inconclusive! #{result}"
          end
        end
        @tear_down_block.call(context) unless @tear_down_block.nil?
      end
      @scenario_tear_down_block.call(context) unless @scenario_tear_down_block.nil?
      @@current_scenario = nil

      puts "Scenario #{@id} finished, #{@tests_run} tests, #{@expectations_run} expectations with #{@expectations_met} successful and #{@expectations_not_met} failures."
    end

    def add_test(test)
      @tests.push test
      @current_test = test
    end

    attr_accessor :desc, :block, :set_up_block, :tests, :tear_down_block, :current_test,
                  :scenario_set_up_block, :scenario_tear_down_block, :namespace
  end

end
