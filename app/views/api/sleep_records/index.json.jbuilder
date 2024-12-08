# frozen_string_literal: true

json.array!(@sleep_records) do |record|
  json.id record.id
  json.clock_in record.clock_in
  json.clock_out record.clock_out
  json.duration record.duration
  json.created_at record.created_at
  json.updated_at record.updated_at
end
