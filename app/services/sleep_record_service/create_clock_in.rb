# frozen_string_literal: true

module SleepRecordService
  # This service will create the sleep record
  class CreateClockIn < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      validate_previous_record(@user)

      create_sleep_record!(@user)
    end

    private

    attr_reader :user

    def create_sleep_record!(user)
      user.sleep_records.create!(clock_in: Time.current)
    end

    def validate_previous_record(user)
      previous_record = user.sleep_records.where(clock_out: nil).last

      return unless previous_record

      raise Exceptions::GeneralError.new(I18n.t('sleep_record.record_not_completed'), :bad_request, 400)
    end
  end
end
