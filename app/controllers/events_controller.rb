class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish, :cancel]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to event_path(@event), notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted."
  end

  def publish
    if @event.draft?
      @event.update(status: "published")
      redirect_to event_path(@event), notice: "Event was successfully published."
    else
      redirect_to event_path(@event), alert: "Only draft events can be published."
    end
  end

  def cancel
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
    params.require(:event).permit(
      :title,
      :description,
      :start_date,
      :end_date,
      :capacity,
      :creator_id,
      :category_id,
      :venue_id
    )
  end
end