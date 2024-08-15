# <p><%= @member.first_name%></p>
# <p><%= @member.last_name%></p>
# <p><%= @member.city%></p>
# <p><%= @member.state%></p>
# <p><%= @member.country%></p>
# app/views/members/create.json.jbuilder
json.id @member.id
json.first_name @member.first_name
json.last_name @member.last_name
json.city @member.city
json.state @member.state
json.country @member.country
json.team @member.team


