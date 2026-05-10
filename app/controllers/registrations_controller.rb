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
    event = @registration.event
    was_confirmed = @registration.confirmed?

    @registration.update(status: "cancelled")

    promote_first_waiting_registration(event) if was_confirmed

    redirect_to registrations_path, notice: "Registration was successfully cancelled."
  end

  private

  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:user_id, :event_id, :status)
  end

  def promote_first_waiting_registration(event)
    next_registration = event.registrations
                             .waiting_list
                             .order(:created_at)
                             .first

    next_registration&.update(status: "confirmed")
  end
end