# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::FollowsController', type: :request do
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

  describe 'GET #follower' do
    before { user.followees << other_user }

    it 'returns the list of followers' do
      get '/api/users/followers', headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq([{ 'email_address' => other_user.email_address, 'id' => other_user.id,
                                            'name' => other_user.name }])
    end
  end

  describe 'GET #followee' do
    before { other_user.followees << user }

    it 'returns the list of followees' do
      get '/api/users/followees', headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to eq([{ 'email_address' => other_user.email_address, 'id' => other_user.id,
                                            'name' => other_user.name }])
    end
  end

  describe 'POST #create' do
    it 'follow user' do
      post "/api/users/#{other_user.id}/follow", headers: headers

      expect(response).to have_http_status(:created)
      expect(response.parsed_body).to eq({ 'email_address' => other_user.email_address, 'id' => other_user.id,
                                           'name' => other_user.name })
    end
  end

  describe 'DELETE #destroy' do
    before { user.followees << other_user }

    it 'unfollow user' do
      delete "/api/users/#{other_user.id}/unfollow", headers: headers

      expect(response).to have_http_status(:no_content)
    end
  end
end
