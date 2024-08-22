# frozen_string_literal: true

module Members
  class TeamsController < ApplicationController
    def update
      @member = Member.find(params[:member_id])
      team = Team.find(params[:id])
      return unless @member.update!(team: team)

      render json: { message: 'Member team updated successfully' }, status: :ok
    end
  end
end
