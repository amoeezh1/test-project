class TeamsController < ApplicationController
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
        if @team.save
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
        if @team.update(team_params)
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
        @team.destroy
        respond_to do |format|
          format.json { render json: { message: "Project deleted successfully" }, status: :ok }
        end
      end
  
  
      private
  
  
      def team_params
          params.require(:team).permit(:name)
      end
end
