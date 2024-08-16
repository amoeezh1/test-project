class MembersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :handle_exception

    # before_action :set_member, only: [:show, :edit, :update]
    protect_from_forgery with: :null_session
    def index
      @members = Member.all
    
      if @members.any?
        respond_to do |format|
          format.json # responds with index.json.jbuilder
        end
      else
        render json: { message: 'No members found' }, status: :not_found
      end
    end
    
  
    def show
        @member = Member.find(params[:id])
        if @member.any?
          respond_to do |format|
            format.json # responds with index.json.jbuilder
          end
        else
          render json: { message: 'No such member found' }, status: :not_found
        end
    end
    
      def add_project
        member = Member.find(params[:id])
        project = Project.find(params[:project_id])
    
        if member.projects << project
          render json: { message: 'Member added to project successfully' }, status: :ok
        else
          render json: { errors: member.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
    def update_team
      team = Team.find(params[:team_id])
      @member= Member.find(params[:id])
      if member.update!(team: team)
        render json: { message: 'Member team updated successfully' }, status: :ok
      else
        render json: { errors: @member.errors.full_messages }, status: :unprocessable_entity
      end
    end
    def create

      team_name=params.dig(:member,:team,:name)
      team=Team.find_or_create_by(name: team_name)
      @member = Member.new(member_params)
      @member.team=team
      if @member.save!
        respond_to do |format|
          format.json { render :show, status: :created, location: @member }
        end
      else
        respond_to do |format|
          format.json { render json: @member.errors}
        end
      end
    end
  
    def update
        @member = Member.find(params[:id])
        @member.update!(member_params)
        respond_to do |format|
          format.json { render :show, status: :ok, location: @member }
        end
    
    end
    def destroy 
        @member=Member.find(params[:id])
        @member.destroy!
        respond_to do |format|
            format.json { render json: { message: "Member deleted successfully" }, status: :ok }
  
          end
    end
    private
    def record_not_found
      render json: { error: "Member not found" }, status: :not_found
    end
  
    def record_invalid(exception)
      render json: { error: "Invalid record" }, status: :unprocessable_entity
    end
    def handle_exception(exception)
      render json: { error: "An error occurred: #{exception.message}" }, status: :internal_server_error
    end
    def member_params
      params.require(:member).permit(:first_name, :last_name, :city, :state, :country)
    end
 
  end
  