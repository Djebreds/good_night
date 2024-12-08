# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'email normalization' do
    it 'normalizes email addresses to lowercase' do
      user = described_class.create!(name: 'User Test', email_address: 'UseR@example.com', password: 'password@123')

      expect(user.email_address).to eq('user@example.com')
    end
  end
end
