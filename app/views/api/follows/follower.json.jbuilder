# frozen_string_literal: true

json.array!(@followers) do |follower|
  json.id follower.id
  json.name follower.name
  json.email_address follower.email_address
end
