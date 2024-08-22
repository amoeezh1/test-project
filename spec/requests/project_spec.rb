# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let!(:project) { create(:project) }

  describe 'GET /projects' do
    it 'returns a success response' do
      get projects_path, as: :json
      expect(response.body).to include('Test Project')
    end
    it 'returns an empty array when no projects exist' do
      Project.delete_all
      get projects_path, as: :json
      expect(response.body).to eq('[]')
    end
  end

  describe 'GET /projects/:id' do
    it 'returns the requested project' do
      get project_path(project), as: :json
      expect(response.body).to include('Test Project')
    end

    it 'returns an empty array when no projects exist' do
      Project.delete_all
      get project_path(project), as: :json
      json_response = JSON.parse(response.body)
      expected_response = {
        'error' => "Couldn't find Project with 'id'=#{project.id}"
      }
      expect(json_response).to eq(expected_response)
    end
  end

  describe 'POST /projects' do
    it 'returns a success response' do
      post projects_path, params: { project: { name: 'Project A' } }, as: :json
      json_response = JSON.parse(response.body)
      last = Project.last
      expected_response = {
        'id' => last.id,
        'name' => last.name,
        'members' => []
      }
      expect(json_response).to eq(expected_response)
    end
    it ' wrong datatype given' do
      post projects_path, params: { project: { name: 111 } }, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include('only allows letters')
    end
    it ' nothing given' do
      post projects_path, params: { project: {} }, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include('value is empty')
    end
    it ' wrong key given' do
      post projects_path, params: { team: {} }, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include('value is empty')
    end
  end
  describe 'PUT /projects/:id' do
    it 'updates the requested project' do
      put project_path(project), params: { project: { name: 'Updated Project' } }
      project.reload
      expect(project.name).to eq('Updated Project')
    end
    it 'wrong id passed' do
      put project_path(30), params: { project: { name: 'Jane' } }
      expect(response.body).to include("Couldn't find")
    end
    it ' wrong datatype given' do
      post projects_path, params: { project: { name: 111 } }, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include('only allows letters')
    end
    it ' nothing given' do
      post projects_path, params: { project: {} }, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include('value is empty')
    end
  end

  describe 'DELETE /projects/:id' do
    it 'destroys the requested project' do
      delete project_path(project)
      expect(Project.exists?(project.id)).to be_falsey
    end
    it 'wrong id passed' do
      put project_path(30)
      expect(response.body).to include("Couldn't find")
    end
  end
end
