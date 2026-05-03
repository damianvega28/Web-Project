class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @organized_events = @user.organized_events
    @registrations = @user.registrations
  end
end