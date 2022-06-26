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
              UserAllowance.create!(user_id: member.user_id, license_id: license.license_id, project_id: @project.id, date: @project.date, price: license.license.fee)
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
      leader_allowance = UserAllowance.find_or_initialize_by(license_id: @leader_license.id, project_id: @project.id)
      if leader_allowance.new_record?
        UserAllowance.create(user_id: @project.leader_id, license_id: @leader_license.id, project_id: @project.id, date: @project.date, price: @leader_license.fee)
      else
        leader_allowance.update(user_id: @project.leader_id)
      end

      @driver_license = License.find_by(title: "運転手当")
      #1ドライバ―のユーザーidを取得
      drivers = Driver.where(project_id: @project.id)
      #2UserAllowanceにふくまれるuser_idを取得
      original_user_allowances = UserAllowance.where(license_id: @driver_license.id, project_id: @project.id)
      #3ドライバ―に含まれてuserAllowanceに含まれないものを追加する
      drivers.each do |driver|
        if original_user_allowances.find_by(user_id: driver.user_id) == nil
          UserAllowance.create(user_id: driver.user_id, license_id: @driver_license.id, project_id: @project.id, date: @project.date, price: @driver_license.fee)
        end
      end
      #4UserAllowanceに含まれてドライバ―に含まれないものを追加する
      original_user_allowances.each do |original_user_allowance|
        if drivers.find_by(user_id: original_user_allowance.user_id) == nil
          original_user_allowance.destroy
        end
      end

      @trip_license = License.find_by(title: "出張手当")
      #1出張のユーザーidを取得
      trips = Trip.where(project_id: @project.id)
      #2UserAllowanceにふくまれるuser_idを取得
      original_user_allowances = UserAllowance.where(license_id: @trip_license.id, project_id: @project.id)
      #3出張に含まれてuserAllowanceに含まれないものを追加する
      trips.each do |trip|
        if original_user_allowances.find_by(user_id: trip.user_id) == nil
          UserAllowance.create(user_id: trip.user_id, license_id: @trip_license.id, project_id: @project.id, date: @project.date, price: @trip_license.fee)
        end
      end
      #4UserAllowanceに含まれて出張に含まれないものを追加する
      original_user_allowances.each do |original_user_allowance|
        if trips.find_by(user_id: original_user_allowance.user_id) == nil
          original_user_allowance.destroy
        end
      end

      @registration_license = License.find_by(title: "規制手当")
      registration_licenses = UserAllowance.where(license_id: @registration_license.id, project_id: @project.id)

      if registration_licenses.count > 0
        # 規制がtrueからfalseに変更した時　できた
        if @project.is_registration == false
          registration_licenses.destroy_all
        end
      else
        # 規制がfalseからtrueに変更した時 出来てない
        if @project.is_registration == true
          @project.project_users.each do |user|
            UserAllowance.create!(user_id: user.user_id, license_id: @registration_license.id, project_id: @project.id, date: @project.date, price: @registration_license.fee)
          end
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
              UserAllowance.create!(user_id: member.user_id, license_id: license.license_id, project_id: @project.id, date: @project.date, price: license.license.fee)
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
    if @project.destroy
      flash[:success] = "伝票の削除に成功しました。"
      redirect_to admin_projects_path
    else
      render "edit"
      flash[:danger] = "伝票の削除に失敗しました。"
    end
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
