require 'rails_helper'

RSpec.describe "Teams", type: :request do
  let!(:team) { Team.create(name: "Test Team") }

  describe "GET /teams" do
    it "returns a success response" do
      get teams_path
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /teams/:id" do
    it "returns the requested team" do
      get team_path(team)
      expect(response.body).to include("Test Team")
    end
  end


  describe "PUT /teams/:id" do
    it "updates the requested team" do
      put team_path(team), params: { team: { name: "Updated Team" } }
      team.reload
      expect(team.name).to eq("Updated Team")
    end
  end

  describe "DELETE /teams/:id" do
    it "destroys the requested team" do
     delete team_path(team)
     expect(Team.exists?(team.id)).to be_falsey
    end
  end
end
