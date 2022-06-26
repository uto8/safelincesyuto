class Admin::LicensesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user

  def index
    @licenses = License.page(params[:page]).per(10).order(created_at: :desc)
  end

  def new
    @license = License.new
  end

  def create
    @license = License.create(license_params)
    if @license.save
      flash[:success] = "資格の作成に成功しました。"
      redirect_to admin_licenses_path
    else
      render "new"
    end
  end

  def edit
    @license = License.find(params[:id])
  end

  def update
    @license = License.find(params[:id])
    if @license.update(license_params)
      flash[:success] = "資格の編集に成功しました。"
      redirect_to admin_licenses_path
    else
      render "edit"
    end
  end

  def destroy
    @license=License.find(params[:id])
    begin
      @license.destroy
      flash[:success] = "資格の削除に成功しました。"
      redirect_to admin_licenses_path
    rescue
      render "edit"
      flash[:danger] = "資格の削除に失敗しました。"
    end
  end

  private
  def license_params
    params.require(:license).permit(:title, :fee)
  end

  def admin_user
    redirect_to root_path unless current_user.is_admin == true
  end
end
