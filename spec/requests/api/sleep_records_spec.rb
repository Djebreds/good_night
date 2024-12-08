# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::SleepRecords', type: :request do
  let(:user) do
    User.find_by(email_address: 'testuser@example.com') || create(:user, email_address: 'testuser@example.com')
  end
  let(:other_user) do
    User.find_by(email_address: 'otheruser@example.com') || create(:user, email_address: 'otheruser@example.com')
  end
  let(:session_record) { create(:session, user: user) }

  let(:headers) do
    {
      'Authorization' => session_record.token,
      'Content-Type' => 'application/json'
    }
  end

  before do
    allow(Current).to receive(:user).and_return(user)
  end

  describe 'GET /api/users/sleep_records' do
    it 'returns a list of the user\'s sleep records' do
      get '/api/users/sleep_records', headers: headers

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/users/sleep_records/clock_in' do
    it 'creates a new clock-in sleep record' do
      expect do
        post '/api/users/sleep_records/clock_in', headers: headers
      end.to change(SleepRecord, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /api/users/sleep_records/clock_out' do
    let(:ongoing_sleep_record) { create(:sleep_record, user: user, clock_in: 1.hour.ago, clock_out: nil) }

    it 'updates the sleep record with clock-out time' do
      ongoing_sleep_record
      put '/api/users/sleep_records/clock_out', headers: headers

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/users/following/sleep_records' do
    let(:followee) { create(:user) }
    let(:headers) { { 'Authorization' => session_record.token, 'Content-Type' => 'application/json' } }

    before do
      user.followees << followee
      create_list(:sleep_record, 2, user: followee, clock_in: 1.hour.ago, clock_out: Time.current)
    end

    it 'returns sleep records of followees' do
      get '/api/users/following/sleep_records', headers: headers

      expect(response).to have_http_status(:ok)
    end
  end
end
