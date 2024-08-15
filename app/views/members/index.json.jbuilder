# <h1> MEMBERS LIST </h1>
# <% count=0%>
# <% @members.each do |i|  %>
#     <h2>Member <%= count +1 %></h2>
#     <p>First Name = <%= i.first_name %></p>
#    <p> Last Name = <%= i.last_name %></p>
#     <p>City = <%= i.city %></p>
#     <p>State = <%= i.state %></p>
#     <p>Country = <%= i.country%></p>
#     <%= link_to 'Edit', edit_member_path(i) %>
#     <%= link_to 'Delete', i, method: :delete, data: { confirm: 'Are you sure?' } %>
  
# <%end %>

json.array! @members do |member|
    json.extract! member, :id, :first_name, :last_name, :city, :state, :country, :team
  end
  