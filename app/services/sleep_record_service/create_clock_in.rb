# frozen_string_literal: true

module SleepRecordService
  # This service will create the sleep record
  class CreateClockIn < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      create_sleep_record!(@user)
    end

    private

    attr_reader :user

    def create_sleep_record!(user)
      user.sleep_records.create!(clock_in: Time.current)
    end
  end
end
