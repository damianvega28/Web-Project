class VenuesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_venue, only: [:show, :edit, :update, :destroy]

  def index
    @venues = policy_scope(Venue)
  end

  def show
    authorize @venue
    @events = @venue.events
  end

  def new
    @venue = Venue.new
    authorize @venue
  end

  def create
    @venue = Venue.new(venue_params)
    authorize @venue

    if @venue.save
      redirect_to venue_path(@venue), notice: "Venue was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @venue
  end

  def update
    authorize @venue

    if @venue.update(venue_params)
      redirect_to venue_path(@venue), notice: "Venue was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @venue

    @venue.destroy
    redirect_to venues_path, notice: "Venue was successfully deleted."
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(policy(@venue || Venue).permitted_attributes)
  end
end