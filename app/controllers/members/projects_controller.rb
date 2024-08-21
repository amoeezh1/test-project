module Members
  class ProjectsController < ApplicationController
    
    def create
        member = Member.find(params[:member_id])
        project = Project.find(params[:project_id])
        if member.projects << project
          render json: { message: 'Member added to project successfully' }, status: :ok       
      end
    end
  end
end
