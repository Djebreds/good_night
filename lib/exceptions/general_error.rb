# frozen_string_literal: true

module Exceptions
  class GeneralError < GoodNightError
    def initialize(message, status, code = '400')
      @message = message
      @status = status
      @code = code
      super(message)
    end

    def _code
      @code
    end

    def _status
      @status
    end

    def _message
      @message
    end
  end
end
