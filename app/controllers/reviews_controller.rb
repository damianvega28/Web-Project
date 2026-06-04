class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = policy_scope(Review)
  end

  def show
    authorize @review
  end

  def new
    @review = Review.new(event_id: params[:event_id])
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user

    authorize @review

    if @review.save
      redirect_to event_path(@review.event), notice: "Review was successfully created."
    else
      redirect_to event_path(@review.event), alert: @review.errors.full_messages.to_sentence
    end
  end

  def edit
    authorize @review
  end

  def update
    authorize @review

    if @review.update(review_params)
      redirect_to event_path(@review.event), notice: "Review was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @review

    event = @review.event
    @review.destroy
    redirect_to event_path(event), notice: "Review was successfully deleted."
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(policy(@review || Review).permitted_attributes)
  end
end