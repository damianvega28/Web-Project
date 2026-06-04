class RegistrationPolicy < ApplicationPolicy
  def index?
    signed_in?
  end

  def show?
    admin? || own_registration?
  end

  def create?
    signed_in?
  end

  def update?
    admin? || own_registration?
  end

  def destroy?
    admin? || own_registration?
  end

  def cancel?
    admin? || own_registration?
  end

  def permitted_attributes
    if admin?
      [:user_id, :event_id, :status]
    elsif signed_in?
      [:event_id]
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

  def own_registration?
    signed_in? && record.user_id == user.id
  end
end