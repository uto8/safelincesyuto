module Admin::UsersHelper
  def admin?
    current_user.is_admin == true
  end
end
