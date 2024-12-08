# frozen_string_literal: true

module Exceptions
  class InvalidAuthError < GoodNightError
    def _code
      401
    end

    def _status
      :unauthorized
    end

    def _message
      I18n.t 'exceptions.invalid_auth'
    end
  end
end
