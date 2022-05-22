class Admin::ProjectsController < ApplicationController
  def index
    @projects = Project.page(params[:page]).per(10)
  end

  def new
    @project = Project.new
    @users = User.all
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      flash[:success] = "伝票の作成に成功しました。"
      @leader_license = License.find_by(name: "隊長手当")
      UserAllowance.create(user_id: @project.leader_id, license_id: @leader_license.id, date: @project.date, price: @leader_license.fee)
      @driver_license = License.find_by(name: "運転手当")
      @project.drivers.each do |driver| 
        UserAllowance.create!(user_id: driver.user_id, license_id: @driver_license.id, date: @project.date, price: @driver_license.fee)
      end
      redirect_to admin_projects_path
    else
      render "new"
    end
  end

  def edit
    @project = Project.find(params[:id])
    @users = User.all
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "伝票の編集に成功しました。"
      redirect_to admin_projects_path
    else
      render "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "伝票の削除に成功しました。"
    redirect_to admin_projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :date, :start_time, :end_time, :leader_id, :address, :supplement, :is_read,
       project_users_attributes: [:project_id, :user_id],
       project_licenses_attributes: [:project_id, :license_id],
       drivers_attributes: [:project_id, :user_id],
       trips_attributes: [:project_id, :user_id]
      )
  end
end
