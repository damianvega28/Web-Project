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
      redirect_to event_path(@registration.event), notice: "Registration was successfully created."
    else
      redirect_to event_path(@registration.event), alert: @registration.errors.full_messages.to_sentence
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
    event = @registration.event

    @registration.cancel!

    redirect_to event_path(event), notice: "Registration was successfully cancelled."
  end

  private

  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:user_id, :event_id)
  end
end