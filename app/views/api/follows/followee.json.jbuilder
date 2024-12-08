# frozen_string_literal: true

json.array!(@followees) do |followee|
  json.id followee.id
  json.name followee.name
  json.email_address followee.email_address
end
