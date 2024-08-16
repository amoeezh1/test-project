json.id @member.id
json.first_name @member.first_name
json.last_name @member.last_name
json.city @member.city
json.state @member.state
json.country @member.country
 json.team do
    json.extract! @member.team, :id, :name 
  end


