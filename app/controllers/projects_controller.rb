class ProjectsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :handle_exception
    protect_from_forgery with: :null_session
    def show
        @project=  Project.find(params[:id])
        if @project.any?
          respond_to do |format|
            format.json # responds with index.json.jbuilder
          end
        else
          render json: { message: 'No such project found' }, status: :not_found
        end
      end
  
      def index
          @projects=Project.all 
          if @projects.any?
            respond_to do |format|
              format.json # responds with index.json.jbuilder
            end
          else
            render json: { message: 'No Projects found' }, status: :not_found
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
        if @project.save!
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
        if @project.update!(project_params)
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
        @project.destroy!
        respond_to do |format|
            format.json { render json: { message: "Project deleted successfully" }, status: :ok }
        end
      end
  
  
      private
      def record_not_found
        render json: { error: "Project not found" }, status: :not_found
      end
    
      def record_invalid(exception)
        render json: { error: "Invalid record" }, status: :unprocessable_entity
      end
      def handle_exception(exception)
        render json: { error: "An error occurred: #{exception.message}" }, status: :internal_server_error
      end
  
      def project_params
          params.require(:project).permit(:name)
      end
end
