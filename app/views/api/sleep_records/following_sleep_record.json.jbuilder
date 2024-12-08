# frozen_string_literal: true

json.array!(@records) do |record|
  json.name record.user.name
  json.duration record.duration
end
