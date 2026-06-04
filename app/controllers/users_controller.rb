class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = policy_scope(User)
  end

  def show
    authorize @user

    @organized_events = @user.organized_events
    @registrations = @user.registrations
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end