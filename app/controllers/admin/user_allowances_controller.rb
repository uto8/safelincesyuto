class Admin::UserAllowancesController < ApplicationController
  def index
    @monthly_allowance = UserAllowance.group("DATE_FORMAT(date, '%Y%m')").select("DATE_FORMAT(date, '%Y%m') as month")
  end
  def list
    @monthly_allowance = UserAllowance.where("DATE_FORMAT(date, '%Y%m') = DATE_FORMAT(date, '%Y%m')").group(:user_id).select(":user_id as user")
  end
  def allowance
    @monthly_allowance = UserAllowance.where("(DATE_FORMAT(date, '%Y%m') = DATE_FORMAT(params[:month], '%Y%m')) AND (user_id = param[:user_id])").group(:license_id).select("sum(price) as price")
  end
end
