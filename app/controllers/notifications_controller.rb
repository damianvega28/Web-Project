class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:show, :edit, :update, :destroy, :mark_as_read]

  def index
    @notifications = policy_scope(Notification)
  end

  def show
    authorize @notification
  end

  def new
    @notification = Notification.new
    authorize @notification
  end

  def create
    @notification = Notification.new(notification_params)
    authorize @notification

    if @notification.save
      redirect_to notification_path(@notification), notice: "Notification was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @notification
  end

  def update
    authorize @notification

    if @notification.update(notification_params)
      redirect_to notification_path(@notification), notice: "Notification was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @notification

    @notification.destroy
    redirect_to notifications_path, notice: "Notification was successfully deleted."
  end

  def mark_as_read
    authorize @notification, :update?

    @notification.update(read: true)
    redirect_to notification_path(@notification), notice: "Notification was marked as read."
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(policy(@notification || Notification).permitted_attributes)
  end
end