# frozen_string_literal: true

module Api
  # Handles sleep record API
  class SleepRecordsController < ApplicationController
    before_action :require_authentication

    def clock_in
      @sleep_record = SleepRecordService::CreateClockIn.call(Current.user)

      render :clock_in, status: :created
    end
  end
end
