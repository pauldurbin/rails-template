class HistoricalEventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.deity?
  end

  def update?
    user.deity?
  end

  def destroy?
    user.deity?
  end
end
