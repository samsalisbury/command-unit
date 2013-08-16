module CommandUnit

  @@scenarios = []
  @@current_scenario = nil
  attr_reader :current_scenario

  def scenario(description, &block)
    @@scenarios.push Scenario.new(description, &block)
  end

  def run
    @@scenarios.each do |scenario|
      scenario.run
    end
  end

  def set_up(&set_up_block)
    raise 'set_up must be called from inside a scenario block' if @@current_scenario == nil
    @@current_scenario.set_up_block = set_up_block
  end

  def when_i(desc, &when_i_block)
    raise 'when_i must be called from inside a scenario block' if @@current_scenario == nil
    @@current_scenario.add_test Test.new(desc, &when_i_block)
  end

  def i_expect(desc, &i_expect_block)
    raise 'i_expect must be called from inside a scenario block' if @@current_scenario == nil
    @@current_scenario.current_test.add_expectation Expectation.new(desc, &i_expect_block)
  end

  class Scenario
    def initialize(desc, &block)
      @desc = desc
      @block = block
      @set_up_block = nil
      @tests = []
      @current_test = nil
      @tear_down_block = nil
    end

    def run
      puts "Running scenario: #{@desc}"
      @@current_scenario = self
      @block.call
      @tests.each do |test|
        puts "When I #{test.when_i_text}"
        context = {}
        @set_up_block.call(context) unless @set_up_block.nil?
        test.when_i_block.call(context) unless test.when_i_block.nil?
        print 'I expect '
        test.expectations.each do |expectation|
          puts expectation.desc
          expectation.block.call(context) unless expectation.block.nil?
        end
      end
      @@current_scenario = nil
    end

    def add_test(test)
      @tests.push test
      @current_test = test
    end

    attr_accessor :desc, :block, :set_up_block, :tests, :tear_down_block, :current_test
  end

  class Test
    def initialize(when_i_text, &when_i_block)
      @when_i_text = when_i_text
      @when_i_block = when_i_block
      @expectations = []
    end
    attr_reader :when_i_text, :when_i_block, :expectations
    def add_expectation(expectation)
      @expectations.push expectation
    end
  end

  class Expectation
    def initialize(expectation_text, &expectaton_block)
      @desc = expectation_text
      @block = expectaton_block
    end
    attr_accessor :desc, :block
  end

end