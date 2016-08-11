class PostPolicy < ApplicationPolicy

  def new?
    user.present? && user.admin?
  end

  def edit?
    user.present? && record.user_id == user.id || user_has_power?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private
  def user_has_power?
    user.admin? || user.moderator?
  end
end
