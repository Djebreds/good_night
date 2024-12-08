# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Session, type: :model do
  describe 'token generation' do
    it 'generates a token before create' do
      user = create(:user)
      session = user.sessions.create!(user_agent: 'Mozilla/5.0', ip_address: '127.0.0.1')

      expect(session.token).to be_present
    end

    it 'regenerate the token' do
      user = create(:user)
      session = user.sessions.create!(user_agent: 'Mozilla/5.0', ip_address: '127.0.0.1')
      old_token = session.token

      session.regenerate_token!

      expect(session.token).not_to eq(old_token)
    end
  end
end
