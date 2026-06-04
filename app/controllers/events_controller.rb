class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish, :cancel]

  def index
    @events = policy_scope(Event)
  end

  def show
    authorize @event
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.creator ||= current_user

    authorize @event

    if @event.save
      redirect_to event_path(@event), notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted."
  end

  def publish
    authorize @event, :publish?

    if @event.draft?
      @event.update(status: "published")
      redirect_to event_path(@event), notice: "Event was successfully published."
    else
      redirect_to event_path(@event), alert: "Only draft events can be published."
    end
  end

  def cancel
    authorize @event, :cancel?

    if @event.draft? || @event.published?
      @event.update(status: "cancelled")
      redirect_to event_path(@event), notice: "Event was successfully cancelled."
    else
      redirect_to event_path(@event), alert: "Only draft or published events can be cancelled."
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(policy(@event || Event).permitted_attributes)
  end
end