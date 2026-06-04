class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def index
    @registrations = policy_scope(Registration)
  end

  def show
    authorize @registration
  end

  def new
    @registration = Registration.new(event_id: params[:event_id])
    authorize @registration
  end

  def create
    @registration = Registration.new(registration_params)
    @registration.user = current_user

    authorize @registration

    if @registration.save
      redirect_to event_path(@registration.event), notice: "Registration was successfully created."
    else
      redirect_to event_path(@registration.event), alert: @registration.errors.full_messages.to_sentence
    end
  end

  def edit
    authorize @registration
  end

  def update
    authorize @registration

    if @registration.update(registration_params)
      redirect_to registration_path(@registration), notice: "Registration was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @registration

    event = @registration.event
    @registration.cancel!

    redirect_to event_path(event), notice: "Registration was successfully cancelled."
  end

  private

  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(policy(@registration || Registration).permitted_attributes)
  end
end