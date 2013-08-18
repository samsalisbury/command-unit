module CommandUnit

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

end