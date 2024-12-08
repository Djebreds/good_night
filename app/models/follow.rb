# frozen_string_literal: true

# Represents a follow in the application
class Follow < ApplicationRecord
  belongs_to :follower,
             class_name: 'User',
             inverse_of: :followee_relationships

  belongs_to :followee,
             class_name: 'User',
             inverse_of: :follower_relationships

  validates :follower_id, uniqueness: { scope: :followee_id }
  validate :follower_and_followee_are_different

  private

  def follower_and_followee_are_different
    return unless follower_id == followee_id

    errors.add(:followee, 'must be different from follower')
  end
end
