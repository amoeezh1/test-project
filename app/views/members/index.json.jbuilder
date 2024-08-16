json.array! @members do |member|
  json.extract! member, :id, :first_name, :last_name, :city, :state, :country

  # Add the associated team
  json.team do
    json.extract! member.team, :id, :name 
  end
end
