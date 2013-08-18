module CommandUnit

  class ExpectationResult
    def initialize(description, expectation_met)
      @message = description
      @success = expectation_met
    end
    attr_reader :message
    def success?
      @success
    end
  end

end