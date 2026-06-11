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
    event = Event.find(registration_params[:event_id])

    @registration = Registration.find_by(user: current_user, event: event)

    if @registration.present? && !@registration.cancelled?
      redirect_to event_path(event), alert: "You are already registered for this event."
      return
    end

    if @registration.present? && @registration.cancelled?
      @registration.assign_attributes(
        status: registration_status_for(event),
        registered_at: Time.current
      )
    else
      @registration = Registration.new(
        event: event,
        user: current_user,
        status: registration_status_for(event),
        registered_at: Time.current
      )
    end

    authorize @registration

    if @registration.save
      redirect_to event_path(event), notice: "Registration was successfully created."
    else
      redirect_to event_path(event), alert: @registration.errors.full_messages.to_sentence
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

  def registration_status_for(event)
    event.available_spots.positive? ? "confirmed" : "waiting_list"
  end
end