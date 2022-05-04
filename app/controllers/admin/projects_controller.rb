class Admin::ProjectsController < ApplicationController
  def index
    @projects = Project.page(params[:page]).per(10)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      flash[:success] = "伝票の作成に成功しました。"
      redirect_to admin_projects_path
    else
      render "new"
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "伝票の編集に成功しました。"
      redirect_to admin_projects_path
    else
      render "new"
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
    params.require(:project).permit(:name, :date, :driver, :start_time, :end_time, :leader, :belongings, :address, :supplement)
  end
end
