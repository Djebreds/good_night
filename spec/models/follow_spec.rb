# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:follower) { create(:user) }
  let(:followee) { create(:user) }

  describe 'validations' do
    it 'is invalid if follower and followee are the same' do
      follow = build(:follow, follower: follower, followee: follower)
      expect(follow).to be_invalid
      expect(follow.errors[:followee]).to include('must be different from follower')
    end
  end
end
