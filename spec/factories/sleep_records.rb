# frozen_string_literal: true

FactoryBot.define do
  factory :sleep_record do
    user { nil }
    clock_in { '2024-12-08 21:42:45' }
    clock_out { '2024-12-08 21:42:45' }
  end
end
