# frozen_string_literal: true

# Represents a session in the application
class Session < ApplicationRecord
  belongs_to :user

  before_save :generate_token

  def regenerate_token!
    if frozen?
      dup.regenerate_token!
    else
      generate_token
      save!
    end
  end

  private

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
