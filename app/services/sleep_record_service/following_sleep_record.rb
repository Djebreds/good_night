# frozen_string_literal: true

module SleepRecordService
  # This service will find the following sleep records
  class FollowingSleepRecord < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      find_following_sleep_record(@user)
    end

    private

    attr_reader :user

    def find_following_sleep_record(user)
      SleepRecord
        .includes(:user)
        .where(user: user.followers)
        .where.not(clock_out: nil)
        .where(clock_in: 1.week.ago.beginning_of_day..)
        .select('sleep_records.*, EXTRACT(EPOCH FROM (clock_out - clock_in)) AS duration')
        .order('duration DESC')
    end
  end
end
