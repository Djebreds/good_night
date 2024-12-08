# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'raises ArgumentError if clock_in is nil' do
      expect do
        build(:sleep_record, clock_in: nil, user: user).valid?
      end.to raise_error(ArgumentError)
    end

    it 'is invalid if clock_out is before clock_in' do
      sleep_record = build(:sleep_record, clock_in: Time.zone.now, clock_out: 1.hour.ago, user: user)
      expect(sleep_record).to be_invalid
      expect(sleep_record.errors[:clock_out]).to include('must be after clock_in')
    end

    it 'is valid with a clock_out after clock_in' do
      sleep_record = build(:sleep_record, clock_in: Time.zone.now, clock_out: 1.hour.from_now, user: user)
      expect(sleep_record).to be_valid
    end
  end

  describe '#duration' do
    it 'returns the correct duration as HH:MM:SS' do
      clock_in = Time.zone.now
      clock_out = clock_in + 3.hours + 45.minutes + 10.seconds
      sleep_record = build(:sleep_record, clock_in: clock_in, clock_out: clock_out, user: user)

      expect(sleep_record.duration).to eq('03:45:10')
    end

    it 'returns 00:00:00 if clock_out is the same as clock_in' do
      clock_in = Time.zone.now
      sleep_record = build(:sleep_record, clock_in: clock_in, clock_out: clock_in, user: user)

      expect(sleep_record.duration).to eq('00:00:00')
    end

    it 'returns 00:00:00 if clock_out is blank' do
      clock_in = Time.zone.now
      sleep_record = build(:sleep_record, clock_in: clock_in, clock_out: nil, user: user)

      expect(sleep_record.duration).to eq('00:00:00')
    end
  end
end
