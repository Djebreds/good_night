# frozen_string_literal: true

# Represents a sleep record in the application
class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :clock_out_after_clock_in

  def duration
    clock_out && clock_in ? (clock_out - clock_in).to_i : 0
  end

  private

  def clock_out_after_clock_in
    return if clock_out.blank? || clock_out > clock_in

    errors.add(:clock_out, 'must be after clock_in')
  end
end
