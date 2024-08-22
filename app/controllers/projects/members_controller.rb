# frozen_string_literal: true

module Projects
  class MembersController < ApplicationController
    def index
      @project = Project.find(params[:project_id])
    end

    def create
      member = Member.find(params[:member_id])
      project = Project.find(params[:project_id])
      return unless member.projects << project

      render json: { message: 'Member added to project successfully' }, status: :ok
    end
  end
end
