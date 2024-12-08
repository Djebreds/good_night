# frozen_string_literal: true

module SleepRecordService
  # This service will update the clock out of sleep record
  class UpdateClockOut < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      update_sleep_record!(@user)
    end

    private

    attr_reader :user

    def update_sleep_record!(user)
      latest_sleep_record = user.sleep_records.order(:created_at).last
      latest_sleep_record.update!(clock_out: Time.current)
      latest_sleep_record
    end
  end
end
