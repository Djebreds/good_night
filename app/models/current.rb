# frozen_string_literal: true

# Represent current session context and user delegation
class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :user, to: :session, allow_nil: true
end
