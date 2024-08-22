# frozen_string_literal: true

json.members @project.members do |_member|
  json.extract! @project.members, :id, :first_name, :last_name, :city, :state, :country
end
