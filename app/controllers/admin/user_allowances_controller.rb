class Admin::UserAllowancesController < ApplicationController
  def index
    @user_allowances = UserAllowance.all
  end
  def user_list
  end
  def user_allowance
  end
end
