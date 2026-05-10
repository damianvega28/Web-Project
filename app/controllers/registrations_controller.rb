class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def index
    @registrations = Registration.all
  end

  def show
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      redirect_to registration_path(@registration), notice: "Registration was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @registration.update(registration_params)
      redirect_to registration_path(@registration), notice: "Registration was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @registration.destroy
    redirect_to registrations_path, notice: "Registration was successfully deleted."
  end

  private

  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:user_id, :event_id, :status)
  end
end