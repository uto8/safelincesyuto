class Admin::UserAllowancesController < ApplicationController
  def index
    @user_allowances = UserAllowance.all
  end
end
