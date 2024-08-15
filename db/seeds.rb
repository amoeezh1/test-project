# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Member.create do |member|
    member.first_name = "Moeez"
    member.last_name = "Hassan"
    member.city = "Lahore"
    member.state = "Punjab"
    member.country = "Pakistan"
end

Project.create do |member|
    member.name = "ROR"
end
  
Team.create do |member|
    member.name = "Team A"
end
  