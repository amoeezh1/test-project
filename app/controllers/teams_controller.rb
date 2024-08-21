class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])           
  end
  
      def index
        @teams=Team.all     
      end

      def new
        @team=Team.new
      end
  
      def create
        @team=Team.new(create_params)
        @team.save! 
       end
      
      def update        
        @team=Team.find(params[:id])
        @team.update!(create_params)      
      end
  
      def edit
        @team=Team.find(params[:id])
      end

      def destroy
        @team=Team.find(params[:id])
        @team.destroy!
        end 
  
      private  
 
      def create_params
          params.require(:team).permit(:name)
      end
      
end
