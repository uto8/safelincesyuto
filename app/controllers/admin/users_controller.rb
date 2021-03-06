class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, except: :show

  def index
    @users = User.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  # 同じ値が入らないようにする
  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "社員の作成に成功しました。"
      redirect_to admin_users_path
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "社員の編集に成功しました。"
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:success] = "社員の削除に成功しました。"
      redirect_to admin_users_path
    rescue
      render "edit"
      flash[:danger] = "社員の削除に失敗しました。"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :is_admin, license_users_attributes: [:id, :license_id, :user_id, :_destroy])
  end

  def admin_user
    redirect_to root_path unless current_user.is_admin == true
  end
end
