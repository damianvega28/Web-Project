class NotificationPolicy < ApplicationPolicy
  def index?
    signed_in?
  end

  def show?
    admin? || own_notification?
  end

  def update?
    admin? || own_notification?
  end

  def destroy?
    admin? || own_notification?
  end

  def permitted_attributes
    if admin?
      [:user_id, :message, :read]
    elsif signed_in?
      [:read]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if admin?
        scope.all
      elsif signed_in?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end

  private

  def own_notification?
    signed_in? && record.user_id == user.id
  end
end