# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'when valid credentials are provided' do
      before do
        post :create, params: { email_address: user.email_address, password: user.password }
      end

      it 'creates a new session and returns a token' do
        expect(response).to have_http_status(:created)
        json_response = response.parsed_body
        expect(json_response['token']).to be_present
      end
    end

    context 'when invalid credentials are provided' do
      before do
        post :create, params: { email_address: user.email_address, password: 'invalid_password' }
      end

      it 'raises an InvalidAuthError' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when rate-limited' do
      before do
        10.times { post :create, params: { email_address: user.email_address, password: user.password } }
      end

      it 'returns a 429 status code for too many requests' do
        post :create, params: { email_address: user.email_address, password: user.password }
        expect(response).to have_http_status(:too_many_requests)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:session_record) { create(:session, user: user) }

    before do
      request.headers['Authorization'] = "Bearer #{session_record.token}"
      allow(Current).to receive(:session).and_return(session_record)
    end

    context 'when session is present' do
      before do
        user_session = user.sessions.create!(user_agent: 'Mozilla/5.0', ip_address: '127.0.0.1')
        allow(Current).to receive(:session).and_return(user_session)

        delete :destroy
      end

      it 'destroys the current session and returns no content' do
        delete :destroy

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when session is not present' do
      before do
        allow(Current).to receive(:session).and_return(nil)

        delete :destroy
      end

      it 'returns unauthorized if session is not found' do
        request.headers['Authorization'] = 'Bearer invalid_token'
        allow(Current).to receive(:session).and_return(nil)

        delete :destroy

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
