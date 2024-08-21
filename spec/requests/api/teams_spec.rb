require 'swagger_helper'

RSpec.describe 'api/teams', type: :request do

    path '/teams' do
      get 'Retrieves all teams' do
        tags 'Teams'
        produces 'application/json'
        response '200', 'teams found' do
          schema type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string }
              },
              required: [ 'id', 'name' ]
            }
  
          run_test!
        end
      end
      path '/teams/{id}' do
        get 'Retrieves a specific team' do
          tags 'Teams'
          produces 'application/json'
          parameter name: :id, in: :path, type: :integer
    
          response '200', 'team found' do
            schema type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string }
              },
              required: [ 'id', 'name' ]
    
            let(:id) { Team.create(name: 'Team A').id }
            run_test!
          end
          end
      end
        post 'Creates a team' do
          tags 'Teams'
          consumes 'application/json'
          produces 'application/json'
          parameter name: :team, in: :body, schema: {
            type: :object,
            properties: {
              name: { type: :string }
            },
            required: [ 'name' ]
          }
    
          response '200', 'team created' do
            let(:team) { { name: 'New Team' } }
            run_test! do |response|
            end
          end
          path '/teams/{id}' do
          put 'Updates a team' do
            tags 'Teams'
            consumes 'application/json'
            produces 'application/json'
            parameter name: :id, in: :path, type: :integer
            parameter name: :team, in: :body, schema: {
              type: :object,
              properties: {
                name: { type: :string }
              },
              required: [ 'name' ]
            }
      
            response '200', 'team updated' do
              let(:id) { Team.create(name: 'Original Team').id }
              let(:team) { { name: 'Updated Team' } }
              run_test! 
            end
          end
        end
        path '/teams/{id}' do
          delete 'Deletes a team' do
            tags 'Teams'
            consumes 'application/json'
            produces 'application/json'
            parameter name: :id, in: :path, type: :integer
            response '200', 'team deleted' do
              let(:id) { Team.create(name: 'Team to be deleted').id }
      
              run_test!
            end
          end
        end
      end
    end
end
