# frozen_string_literal: true

module Api
  # Handles sleep record API
  class SleepRecordsController < ApplicationController
    before_action :require_authentication

    def index
      @sleep_records = Current.user.sleep_records.order(created_at: :desc)

      render :index, status: :ok
    end

    def clock_in
      @sleep_record = SleepRecordService::CreateClockIn.call(Current.user)

      render :clock_in, status: :created
    end

    def clock_out
      @sleep_record = SleepRecordService::UpdateClockOut.call(Current.user)

      render :clock_out, status: :ok
    end
  end
end
