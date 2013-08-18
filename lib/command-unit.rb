require 'stringio'
require_relative 'command-unit/scenario'
require_relative 'command-unit/test'
require_relative 'command-unit/expectation'
require_relative 'command-unit/expectation_result'

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

    @@scenarios.push Scenario.new(namespace, description, STDOUT, &block)

    return @@scenarios.last
  end

  def run_silent(namespace_or_nil=nil)
    output = StringIO.new
    run(namespace_or_nil, output)
    return output.string
  end

  def run(namespace_or_scenario_or_nowt = nil, out_stream=STDOUT)
    if namespace_or_scenario_or_nowt.nil?
      # Run the lot...
      out_stream.puts "\nRunning #{@@scenarios.count} scenarios..."
      @@scenarios.each do |scenario|
        scenario.run(out_stream)
      end
    else
      if namespace_or_scenario_or_nowt.is_a? Symbol
        namespace = namespace_or_scenario_or_nowt
        scenarios_in_namespace = @@scenarios.select { |s| s.namespace == namespace }
        out_stream.puts "\nRunning #{scenarios_in_namespace.length} scenarios in namespace '#{namespace}'..."
        scenarios_in_namespace.each do |scenario|
          scenario.run(out_stream)
        end
      elsif namespace_or_scenario.is_a? Scenario
        scenario = namespace_or_scenario
        out_stream.puts "\nRunning single scenario..."
        scenario.run(out_stream)
      else
        raise "You must pass either a Scenario, a Symbol (namespace), or nil into run. You passed a #{namespace_or_scenario_or_nowt.class}"
      end
    end

    out_stream.puts "\nRan 1 scenario (1 tests, 1 expectation); All passed :)\n"
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

  def pass(desc = '')
    ExpectationResult.new(desc, true)
  end

  def fail(desc = '')
    ExpectationResult.new(desc, false)
  end

end
