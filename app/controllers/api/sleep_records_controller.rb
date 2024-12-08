# frozen_string_literal: true

module Api
  # Handles sleep record API
  class SleepRecordsController < ApplicationController
    before_action :require_authentication

    # GET /api/users/sleep_records
    def index
      @sleep_records = Current.user.sleep_records.order(created_at: :desc)

      render :index, status: :ok
    end

    # POST /api/users/sleep_records/clock_in
    def clock_in
      @sleep_record = SleepRecordService::CreateClockIn.call(Current.user)

      render :clock_in, status: :created
    end

    # PUT /api/users/sleep_records/clock_out
    def clock_out
      @sleep_record = SleepRecordService::UpdateClockOut.call(Current.user)

      render :clock_out, status: :ok
    end

    # GET /api/users/following/sleep_records
    def following_sleep_record
      @records = SleepRecordService::FollowingSleepRecord.call(Current.user)

      render :following_sleep_record, status: :ok
    end
  end
end
