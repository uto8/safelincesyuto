class Admin::UserAllowancesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  require "csv"

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
    @monthly_allowances = UserAllowance.where("(DATE_FORMAT(date,'%Y%m') = #{@month}) AND (user_id = #{@user_id}) ").joins(:license).select(:title, :license_id)
    @monthly_allowances_sum = UserAllowance.where("(DATE_FORMAT(date, '%Y%m') = #{@month}) AND (user_id = #{@user_id})").joins(:license).group(:license_id).select("title, sum(price) as price, count(*) as count, license_id")
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_posts_csv(@monthly_allowances_sum)
      end
    end
  end

  private
  def admin_user
    redirect_to root_path unless current_user.is_admin == true
  end
  def send_posts_csv(sums)
    bom = "\uFEFF"
    csv_data = CSV.generate(bom) do |csv|
      csv_title = %W(#{@user.name}#{@month})
      csv << csv_title
      # トップ
      column_names = []
      column_names.push("手当名")
      # 1.upto(31) do |n|
      #   column_names.push("#{@month}/#{n}")
      # end
      column_names.push("回数","合計金額")
      csv << column_names
      # 手当カレンダー
      sums.each do |sum|
        column_values = []
        column_values.push(sum.title)
        # allowances = UserAllowance.where("(DATE_FORMAT(date,'%Y%m') = #{@month}) AND (user_id = #{@user_id}) ").joins(:license).select("count(*) as count")
        # 1.upto(31) do |n|
        #   if allowances.exists?("DATE_FORMAT(date, '%d') = #{n}")
        #     column_values.push(sum.price)
        #   else
        #     column_values.push("")
        #   end
        # end
        column_values.push(sum.count, sum.price)
        csv << column_values
      end
    end
    send_data(csv_data, filename: "#{@user.name}#{@month}手当.csv")
  end
end
