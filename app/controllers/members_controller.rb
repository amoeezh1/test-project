class MembersController < ApplicationController
    def index
      @members = Member.all             
    end  
  
    def show
        @member = Member.find(params[:id])          
    end   
  
    def create
      team_name=params.dig(:member,:team,:name)
      team=Team.find_or_create_by(name: team_name)
      @member = Member.new(create_params)
      @member.team=team
      @member.save!        
    end
  
    def update
        @member = Member.find(params[:id])
        @member.update!(create_params)           
    end

    def destroy 
        @member=Member.find(params[:id])
        @member.destroy!
    end

    private
  
    def create_params
      params.require(:member).permit(:first_name, :last_name, :city, :state, :country)
    end
 
  end
  