# frozen_string_literal: true

json.extract! project, :id, :name
json.members project.members do |member|
  json.extract! member, :id, :first_name, :last_name, :city, :state, :country
end
