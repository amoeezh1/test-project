require 'rails_helper'

RSpec.describe "Teams", type: :request do
  let!(:team) { create(:team) }

  describe "GET /teams" do
    it "returns a success response" do
      get teams_path,as: :json
      expect(response.body).to include("Test Team")
    end
    it "returns an empty array when no teams exist" do
      Team.delete_all
      get teams_path, as: :json
      expect(response.body).to eq("[]")
    end
  end

  describe "GET /teams/:id" do
    it "returns the requested team" do
      get team_path(team), as: :json
      expect(response.body).to include("Test Team")
    end
    it "returns an empty array when no teams exist" do
      Team.delete_all

      get team_path(team), as: :json
      json_response = JSON.parse(response.body)
      expected_response = {
        "error" => "Couldn't find Team with 'id'=#{team.id}"
  }
      expect(json_response).to eq(expected_response)
    end
  end

  describe "POST /teams" do
    it "returns a success response" do
      post teams_path, params:{team:{name: "Team A"}}, as: :json
      json_response = JSON.parse(response.body)
      last=Team.last
      expected_response = {
        "id" => last.id,
        "name" => last.name,
        "members" => [] 
      }
      expect(json_response).to eq(expected_response)
    end
    it " wrong datatype given" do
      post teams_path, params:{team:{name:111}}, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to include("only allows letters")
    end
    it " nil given" do
      post teams_path, params:{team:{name:nil}}, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to include("can't be blank")
    end
    it " nothing given" do
      post teams_path, params:{team:{}}, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to include("value is empty")
    end
    it " wrong key given" do
      post teams_path, params:{member:{}}, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to include("value is empty")
    end
  end

  describe "PUT /teams/:id" do
    it "updates the requested team" do
      put team_path(team), params: { team: { name: "Updated Team" } }
      team.reload
      expect(team.name).to eq("Updated Team")
    end
    it "wrong id passed" do
      put team_path(30), params: { team: { name: "Jane"} }
    expect(response.body).to include("Couldn't find")
  end
  it " wrong datatype given" do
    post teams_path, params:{team:{name:111}}, as: :json
    json_response = JSON.parse(response.body)
    expect(json_response["error"]).to include("only allows letters")
  end
  it " nil given" do
    post teams_path, params:{team:{name:nil}}, as: :json
    json_response = JSON.parse(response.body)
    expect(json_response["error"]).to include("can't be blank")
  end
  it " nothing given" do
    post teams_path, params:{team:{}}, as: :json
    json_response = JSON.parse(response.body)
    expect(json_response["error"]).to include("value is empty")
  end
  end

  describe "DELETE /teams/:id" do
    it "destroys the requested team" do
     delete team_path(team)
     expect(Team.exists?(team.id)).to be_falsey
    end
    it "wrong id passed" do
      put team_path(30)
    expect(response.body).to include("Couldn't find")
  end
  
  end
end
