require_relative 'scenario'
require_relative 'test'
require_relative 'expectation'
require_relative 'expectation_result'

module CommandUnit

  @@scenario_count = 0

  @@scenarios = []
  @@current_scenario = nil
  attr_reader :current_scenario

  def scenario(namespace_or_description, description_or_nil=nil, &block)
    raise "You must provide a description (String) for each scenario." if namespace_or_description.nil? or description_or_nil.is_a? Symbol
    raise "namespace must be a symbol, if you meant it as a description, use a string instead." if description_or_nil.is_a? String and not namespace_or_description.is_a? Symbol

    if description_or_nil.nil?
      description = namespace_or_description
      namespace = nil
    else
      description = description_or_nil
      namespace = namespace_or_description
    end

    @@scenarios.push Scenario.new(namespace, description, &block)
    return @@scenarios.last
  end

  def run(namespace_or_scenario_or_nowt = nil)
    if namespace_or_scenario_or_nowt.nil?
      # Run the lot...
      @@scenarios.each do |scenario|
        scenario.run
      end
    else
      if namespace_or_scenario_or_nowt.is_a? Symbol
        @@scenarios.each do |scenario|
          next unless scenario.namespace == namespace_or_scenario_or_nowt
          scenario.run
        end
      elsif namespace_or_scenario.is_a? Scenario
        namespace_or_scenario_or_nowt.run
      else
        raise "You must pass either a Scenario, a Symbol (namespace), or nil into run. You passed a #{namespace_or_scenario_or_nowt.class}"
      end
    end
  end

  require 'stringio'

  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    r = out.string
    return r
  ensure
    $stdout = STDOUT
  end

  def ensure_inside_scenario
    raise "#{caller[0]} must be called from inside a scenario block" if @@current_scenario == nil
  end

  def scenario_set_up(&scenario_set_up_block)
    ensure_inside_scenario
    @@current_scenario.scenario_set_up_block = scenario_set_up_block
  end

  def scenario_tear_down(&scenario_tear_down_block)
    ensure_inside_scenario
    @@current_scenario.scenario_tear_down_block = scenario_tear_down_block
  end

  def tear_down(&tear_down_block)
    ensure_inside_scenario
    @@current_scenario.tear_down_block = tear_down_block
  end

  def set_up(&set_up_block)
    ensure_inside_scenario
    @@current_scenario.set_up_block = set_up_block
  end

  def when_i(desc, &when_i_block)
    ensure_inside_scenario
    @@current_scenario.add_test Test.new(desc, &when_i_block)
  end

  def i_expect(desc, &i_expect_block)
    ensure_inside_scenario
    @@current_scenario.current_test.add_expectation Expectation.new(desc, &i_expect_block)
  end

  def success(desc = '')
    ExpectationResult.new(desc, true)
  end

  def failure(desc = '')
    ExpectationResult.new(desc, false)
  end

end
