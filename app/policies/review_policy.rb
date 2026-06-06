class ReviewPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    signed_in?
  end

  def update?
    admin? || own_review?
  end

  def destroy?
    admin? || own_review?
  end

  def permitted_attributes
    if signed_in?
      [:rating, :comment, :event_id]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  private

  def own_review?
    signed_in? && record.user_id == user.id
  end
end