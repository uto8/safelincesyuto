class Admin::ProjectsController < ApplicationController
  before_action :search
  before_action :authenticate_user!

  def search
    @q = Project.order(created_at: :desc).ransack(params[:q])
  end

  def index
    @project_results = @q.result(distinct: true)
    @projects = Project.page(params[:page]).per(10).order(created_at: :desc)
  end

  def new
    @project = Project.new
    @users = User.all
    @licenses = License.where.not(title: "隊長手当").where.not(title: "運転手当").where.not(title: "出張手当").where.not(title: "規制手当")
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      flash[:success] = "伝票の作成に成功しました。"
      @leader_license = License.find_by(title: "隊長手当")
      UserAllowance.create(user_id: @project.leader_id, license_id: @leader_license.id, project_id: @project.id, date: @project.date, price: @leader_license.fee)
      @driver_license = License.find_by(title: "運転手当")
      @project.drivers.each do |driver| 
        UserAllowance.create!(user_id: driver.user_id, license_id: @driver_license.id, project_id: @project.id, date: @project.date, price: @driver_license.fee)
      end
      @trip_license = License.find_by(title: "出張手当")
      @project.trips.each do |trip| 
        UserAllowance.create!(user_id: trip.user_id, license_id: @trip_license.id, project_id: @project.id, date: @project.date, price: @trip_license.fee)
      end
      if @project.is_registration == true
        @registration_license = License.find_by(title: "規制手当")
        @project.project_users.each do |user|
          UserAllowance.create!(user_id: user.user_id, license_id: @registration_license.id, project_id: @project.id, date: @project.date, price: @registration_license.fee)
        end
      end
      # その他資格保存
      @licenses = @project.project_licenses
      @members = @project.project_users
      @licenses.each do |license|
        @members.each do |member|
          @member_licenses = member.user.license_users
          @member_licenses.each do |m|
            if m.license_id == license.license_id
              UserAllowance.create!(user_id: member.user_id, license_id: license.license_id, date: @project.date, price: license.license.fee)
            end
          end
        end
      end
      redirect_to admin_edit_member_license_project_path_path(@project.id)
    else
      render "new"
    end
  end

  def edit_member_license
    @project = Project.find(params[:id])
    @users = User.all
    @members = ProjectUser.where(project: params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    @users = User.all
    @members = ProjectUser.where(project: params[:id])
    @licenses = License.where.not(title: "隊長手当").where.not(title: "運転手当").where.not(title: "出張手当").where.not(title: "規制手当")
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "伝票の編集に成功しました。"
      @leader_license = License.find_by(title: "隊長手当")
      UserAllowance.create(user_id: @project.leader_id, license_id: @leader_license.id, project_id: @project.id, date: @project.date, price: @leader_license.fee)
      @driver_license = License.find_by(title: "運転手当")
      @project.drivers.each do |driver| 
        UserAllowance.create!(user_id: driver.user_id, license_id: @driver_license.id, project_id: @project.id, date: @project.date, price: @driver_license.fee)
      end
      @trip_license = License.find_by(title: "出張手当")
      @project.trips.each do |trip| 
        UserAllowance.create!(user_id: trip.user_id, license_id: @trip_license.id, project_id: @project.id, date: @project.date, price: @trip_license.fee)
      end
      # その他資格保存
      @licenses = @project.project_licenses
      @members = @project.project_users
      @licenses.each do |license|
        @members.each do |member|
          @member_licenses = member.user.license_users
          @member_licenses.each do |m|
            if m.license_id == license.license_id
              UserAllowance.create!(user_id: member.user_id, license_id: license.license_id, date: @project.date, price: license.license.fee)
            end
          end
        end
      end
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
    params.require(:project).permit(:name, :date, :start_time, :end_time, :leader_id, :is_registration, :address, :supplement, :is_read,
       project_users_attributes: [:id,:project_id, :user_id, :_destroy],
       project_licenses_attributes: [:id,:project_id, :license_id, :_destroy],
       drivers_attributes: [:id,:project_id, :user_id, :_destroy],
       trips_attributes: [:id,:project_id, :user_id, :_destroy]
      )
  end
end
