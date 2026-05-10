class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @organized_events = @user.organized_events
    @registrations = @user.registrations
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end