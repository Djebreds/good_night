# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'User Example' }
    email_address { 'user@example.com' }
    password { 'password@123' }
  end
end
