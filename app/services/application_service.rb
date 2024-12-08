# frozen_string_literal: true

# Base class for service
class ApplicationService
  delegate :t, to: :I18n

  def self.call(*)
    new(*).call
  end

  # return value should be ignored
  def call; end
end
