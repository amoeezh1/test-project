class TeamsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :handle_exception
  protect_from_forgery with: :null_session
  def show
    @team = Team.find(params[:id])    
      respond_to do |format|
        format.json 
      end   
  end
  
      def index
        @teams=Team.all         
          respond_to do |format|
            format.json 
          end       
      end

      def new
        @team=Team.new
      end
  
      def create
        @team=Team.new(team_params)
        if @team.save!
            respond_to do |format|
              format.json { render :show, status: :created, location: @team }
            end
        else
          respond_to do |format|
              format.json { render json: @team.errors}
          end
        end
      end


      def show_members
        @team = Team.find(params[:id])
        @member=@team.members
    respond_to do |format|
      format.json 
    end
      end
      
      def update
        @team=Team.find(params[:id])
        if @team.update!(team_params)
            respond_to do |format|
              format.json { render :show, status: :created, location: @team }
            end
        else
          respond_to do |format|
              format.json { render json: @team.errors}
          end
        end
      end
  
      def edit
        @team=Team.find(params[:id])
      end
      def destroy
        @team=Team.find(params[:id])
        @team.destroy!
        respond_to do |format|
          format.json { render json: { message: "Team deleted successfully" }, status: :ok }
        end
      end
  
  
      private
  
      def record_not_found
        render json: { error: "Team not found" }, status: :not_found
      end
    
      def record_invalid(exception)
        render json: { error: "Invalid record" }, status: :unprocessable_entity
      end
      def handle_exception(exception)
        render json: { error: "#{exception.message}" }, status: :internal_server_error
      end
      def team_params
          params.require(:team).permit(:name)
      end
end
