class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy, :mark_as_read]

  def index
    @notifications = Notification.all
  end

  def show
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to notification_path(@notification), notice: "Notification was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @notification.update(notification_params)
      redirect_to notification_path(@notification), notice: "Notification was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @notification.destroy
    redirect_to notifications_path, notice: "Notification was successfully deleted."
  end

  def mark_as_read
    @notification.update(read: true)
    redirect_to notification_path(@notification), notice: "Notification was marked as read."
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:user_id, :title, :message, :type, :read)
  end
end