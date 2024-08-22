# frozen_string_literal: true

json.members @team.members do |member|
  json.extract! member, :id, :first_name, :last_name, :city, :state, :country
end
