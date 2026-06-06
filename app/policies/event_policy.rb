class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || record.ongoing? || record.completed? || admin? || own_event?
  end

  def create?
    signed_in?
  end

  def update?
    admin? || own_event?
  end

  def destroy?
    admin? || own_event?
  end

  def publish?
    admin? || own_event?
  end

  def cancel?
    admin? || own_event?
  end

  def permitted_attributes
    if admin?
      [
        :title,
        :description,
        :start_date,
        :end_date,
        :capacity,
        :status,
        :creator_id,
        :category_id,
        :venue_id
      ]
    elsif signed_in?
      [
        :title,
        :description,
        :start_date,
        :end_date,
        :capacity,
        :category_id,
        :venue_id
      ]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if admin?
        scope.all
      elsif signed_in?
        scope.where(status: ["published", "ongoing", "completed"])
             .or(scope.where(creator_id: user.id))
      else
        scope.where(status: "published")
      end
    end
  end

  private

  def own_event?
    signed_in? && record.creator_id == user.id
  end
end