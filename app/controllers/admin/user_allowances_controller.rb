class Admin::UserAllowancesController < ApplicationController
  def index
    @monthly_allowance = UserAllowance.group("DATE_FORMAT(date, '%Y%m')").select("DATE_FORMAT(date, '%Y%m') as month")
  end
  def list
  end
  def allowance
  end
end
