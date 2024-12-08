# frozen_string_literal: true

# Represents a sleep record in the application
class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :clock_out_after_clock_in

  # Calculates the duration and formats it as HH:MM:SS
  def duration
    return '00:00:00' unless clock_out && clock_in

    total_seconds = (clock_out - clock_in).to_i
    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60
    format('%<hours>02d:%<minutes>02d:%<seconds>02d', hours: hours, minutes: minutes, seconds: seconds)
  end

  private

  def clock_out_after_clock_in
    return if clock_out.blank? || clock_out > clock_in

    errors.add(:clock_out, I18n.t('sleep_record.must_after_clock_in'))
  end
end
