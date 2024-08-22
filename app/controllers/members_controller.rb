# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :set_member, only: %i[show update destroy]

  def index
    @members = Member.all
  end

  def show
    @member
  end

  def create
    team_name = params.dig(:member, :team, :name)
    team = Team.find_or_create_by(name: team_name)
    @member = Member.new(member_params)
    @member.team = team
    @member.save!
  end

  def update
    @member.update!(member_params)
  end

  def destroy
    @member.destroy!
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name, :city, :state, :country)
  end
end
