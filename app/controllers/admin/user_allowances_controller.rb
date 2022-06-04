class Admin::UserAllowancesController < ApplicationController
  def index
    @monthly_allowance = UserAllowance.group("DATE_FORMAT(date, '%Y%m')").select("DATE_FORMAT(date, '%Y%m') as month")
  end
  def list
    @month = params[:month]
    @monthly_allowances = UserAllowance.where("DATE_FORMAT(date,'%Y%m') = #{@month}").joins(:user).group(:user_id).select(:name, :user_id)
    @monthly_allowances_first_date = UserAllowance.find_by("DATE_FORMAT(date,'%Y%m') = #{@month}").date 
  end
  def allowance
    @month = params[:month]
    @user_id = params[:id]
    @user = User.find(params[:id])
    @user_allowances = UserAllowance.where(user_id: @user).joins(:license).select(:date,:title,:license_id,:price)
    @monthly_allowances = UserAllowance.where("(DATE_FORMAT(date,'%Y%m') = #{@month}) AND (user_id = #{@user_id}) ")
    @monthly_allowances_sum = UserAllowance.where("(DATE_FORMAT(date, '%Y%m') = #{@month}) AND (user_id = #{@user_id})").joins(:license).group(:license_id).select("title, sum(price) as price")
  end
end
