module CommandUnit

  class Expectation
    def initialize(expectation_text, &expectaton_block)
      @desc = expectation_text
      @block = expectaton_block
    end
    attr_accessor :desc, :block
  end

end