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
end
