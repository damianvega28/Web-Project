class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to event_path(@review.event), notice: "Review was successfully created."
    else
      redirect_to event_path(@review.event), alert: @review.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to event_path(@review.event), notice: "Review was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    event = @review.event
    @review.destroy
    redirect_to event_path(event), notice: "Review was successfully deleted."
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:user_id, :event_id, :rating, :comment)
  end
end