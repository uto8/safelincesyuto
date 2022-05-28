class Admin::UserAllowancesController < ApplicationController
  def index
    # @user_allowance_group = UserAllowance.group(:date.strftime('%Y/%m'))
    @monthly_allowance = UserAllowance.group("DATE_FORMAT(date, '%Y%m')").select("DATE_FORMAT(date, '%Y%m') as month")
  end
  def user_list
  end
  def user_allowance
  end
end
