# frozen_string_literal: true

# Represents a user from the application
class User < ApplicationRecord
  has_secure_password

  has_many :sleep_records, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :follower_relationships,
           class_name: 'Follow',
           foreign_key: :followee_id,
           inverse_of: :followee,
           dependent: :destroy

  has_many :followers,
           through: :follower_relationships,
           source: :follower

  has_many :followee_relationships,
           class_name: 'Follow',
           foreign_key: :follower_id,
           inverse_of: :follower,
           dependent: :destroy

  has_many :followees,
           through: :followee_relationships,
           source: :followee

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
