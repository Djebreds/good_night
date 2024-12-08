# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::PasswordsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_token) do
    user.generate_password_reset_token!
    user.password_reset_token
  end
  let(:invalid_token) { 'invalid_token' }

  describe 'POST #create' do
    context 'when email address exists' do
      before do
        post :create, params: { email_address: user.email_address }
      end

      it 'sends a password reset email' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when email address does not exist' do
      before do
        post :create, params: { email_address: 'nonexistent@example.com' }
      end

      it 'raises ActiveRecord::RecordNotFound' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
