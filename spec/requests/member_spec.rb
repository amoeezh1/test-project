require 'rails_helper'

RSpec.describe "Members", type: :request do
   let!(:team) { Team.create(name: "Test Team") } 
  let!(:member) { create(:member) }


  describe "GET /members" do
    it "returns a success response" do
      get members_path,as: :json
      expect(response.body).to include("John", "Doe")
    end

    it "returns an empty array when no members exist" do
      Member.delete_all
      get members_path, as: :json
      expect(response.body).to eq("[]")
    end    
  end

  describe "GET /members/:id" do
    it "returns the requested member" do
      get member_path(member),as: :json
      expect(response.body).to include("John", "Doe")
    end

    it "returns the empty member" do
    Member.delete_all

    get member_path(member), as: :json
    json_response = JSON.parse(response.body)
    expected_response = {
      "error" => "Couldn't find Member with 'id'=#{member.id}"
}
    expect(json_response).to eq(expected_response)
  end
  end

  describe "POST /members" do
    it "returns a success response" do
      post members_path, params:{member:{first_name: "Moeez",last_name: "hassan", team: team}}, as: :json
      json_response = JSON.parse(response.body)
      last=Member.last
      expected_response = {
        "id" => last.id,
        "first_name" => last.first_name,
        "last_name" => last.last_name,
        "state" => last.state,
        "city" => last.city,
        "country" => last.country,
        "team" => {
        "id" => team.id,
        "name" => team.name
      }
      }
      expect(json_response).to eq(expected_response)
    end

    it " wrong datatype given" do
      post members_path, params:{member:{first_name: 123,last_name: 44, team: team}}, as: :json
      json_response = JSON.parse(response.body)
      last=Member.last
      expect(json_response["error"]).to include("only allows letters")
    end

    it " nil given" do
      post members_path, params:{member:{first_name: nil,last_name: nil, team: nil}}, as: :json
      json_response = JSON.parse(response.body)
      last=Member.last
      expect(json_response["error"]).to include("can't be blank")
    end

    it " nothing given" do
      post members_path, params:{member:{}}, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to include("value is empty")
    end

    it " wrong key given" do
      post members_path, params:{team:{}}, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to include("value is empty")
    end
  end

  describe "PUT /members/:id" do
    it "updates the requested member" do
      put member_path(member), params: { member: { first_name: "Jane", last_name: "Doe" } }
      member.reload
      expect(member.first_name).to eq("Jane")
      expect(member.last_name).to eq("Doe")
    end

    it "wrong id passed" do
        put member_path(30), params: { member: { first_name: "Jane", last_name: "Doe" } }
      expect(response.body).to include("Couldn't find")
    end

    it " wrong datatype given" do
      post members_path, params:{member:{first_name: 123,last_name: 44, team: team}}, as: :json
      json_response = JSON.parse(response.body)
      last=Member.last
      expect(json_response["error"]).to include("only allows letters")
    end

    it " nil given" do
      post members_path, params:{member:{first_name: nil,last_name: nil, team: nil}}, as: :json
      json_response = JSON.parse(response.body)
      last=Member.last
      expect(json_response["error"]).to include("can't be blank")
    end

    it " nothing given" do
      post members_path, params:{member:{}}, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to include("value is empty")
    end
  end

  describe "DELETE /members/:id" do
    it "destroys the requested member" do
      delete member_path(member)
      expect(Member.exists?(member.id)).to be_falsey
    end
    
    it "wrong id passed" do
      put member_path(30)
    expect(response.body).to include("Couldn't find")
  end
  end
end
