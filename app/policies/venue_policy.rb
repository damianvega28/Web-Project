class VenuePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def permitted_attributes
    if admin?
      [:name, :address, :capacity]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end