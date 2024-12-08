# frozen_string_literal: true

module Exceptions
  class GoodNightError < StandardError
    attr_reader :code, :status

    # this helps to get _code from static method
    def self.code
      new._code
    end

    def initialize(message = nil)
      super
      @message = message || _message
      @code = code || _code
      @status = status || _status
    end

    def to_s
      @message || self.class.to_s
    end

    def _code
      500
    end

    def _message; end

    def _status; end
  end
end
