class Admin::LicensesController < ApplicationController
  def index
    @licenses = License.page(params[:page]).per(10)
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
      render "new"
    end
  end

  def destroy
    @license=License.find(params[:id])
    @license.destroy
    redirect_to admin_licenses_path
  end

  private
  def license_params
    params.require(:license).permit(:name, :fee)
  end
end
