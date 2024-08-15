class ProjectsController < ApplicationController
    protect_from_forgery with: :null_session
    def show
        @project=  Project.find(params[:id])
        respond_to do |format|
            format.json # responds with index.json.jbuilder
          end
      end
  
      def index
          @projects=Project.all 
          respond_to do |format|
            format.json # responds with index.json.jbuilder
          end
      end
      def new
          @project=Project.new
          
      end
      def show_members
        @project = Project.find(params[:id])
    respond_to do |format|
      format.json 
    end
      end
      def create
        @project=Project.new(project_params)
        if @project.save
            respond_to do |format|
                format.json { render :show, status: :created, location: @project }
            end
        else
            respond_to do |format|
                format.json { render json: @project.errors}
            end
        end
      end
  
      def update
        @project=Project.find(params[:id])
        if @project.update(project_params)
            respond_to do |format|
                format.json { render :show, status: :created, location: @project }
            end
        else
            respond_to do |format|
                format.json { render json: @project.errors}
            end
        end
      end
  
      def edit
        @project=Project.find(params[:id])
      end
      def destroy
        @project=Project.find(params[:id])
        @project.destroy
        respond_to do |format|
            format.json { render json: { message: "Project deleted successfully" }, status: :ok }
        end
      end
  
  
      private
  
  
      def project_params
          params.require(:project).permit(:name)
      end
end
