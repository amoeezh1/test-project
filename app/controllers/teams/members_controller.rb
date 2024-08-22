# frozen_string_literal: true

module Teams
  class MembersController < ApplicationController
    def index
      @team = Team.find(params[:team_id])
      @member = @team.members
    end
  end
end
