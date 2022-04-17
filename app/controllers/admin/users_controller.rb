class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "社員の作成に成功しました"
			redirect_to admin_users_path
    else
      flash[:danger] = "ユーザー作成に失敗しました"
			render "new"
    end
  end

  def show
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
      render "new"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :license_id, :admin)
    end
end
