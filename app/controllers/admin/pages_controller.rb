class Admin::PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user

  def index
  end
  
  private
  def admin_user
    redirect_to root_path unless current_user.is_admin == true
  end
end
