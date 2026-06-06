class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin? || own_user?
  end

  def create?
    admin?
  end

  def update?
    admin? || own_user?
  end

  def destroy?
    admin?
  end

  def permitted_attributes
    if admin?
      [:name, :email, :role]
    elsif own_user?
      [:name, :email]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if admin?
        scope.all
      elsif signed_in?
        scope.where(id: user.id)
      else
        scope.none
      end
    end
  end

  private

  def own_user?
    signed_in? && record.id == user.id
  end
end