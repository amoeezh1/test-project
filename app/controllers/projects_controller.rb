class ProjectsController < ApplicationController
  
    def show
        @project=  Project.find(params[:id])
    end
  
      def index
        @projects=Project.all  
      end

      def new
          @project=Project.new          
      end
    
      def create
        @project=Project.new(create_params)
        @project.save! 
      end
  
      def update
        @project=Project.find(params[:id])
       @project.update!(create_params)          
      end
  
      def edit
        @project=Project.find(params[:id])
      end

      def destroy
        @project=Project.find(params[:id])
        @project.destroy!
      end
  
  
      private
  
      def create_params
          params.require(:project).permit(:name)
      end
      
end
