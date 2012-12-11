#encoding: utf-8
class UsersController < ApplicationController
  def index
    @admins = User.admins.paginate(page: params[:page])
    @not_admins = User.waiting_for_reviewed.paginate(page: params[:page])
  end

  def approve
    @user = User.find(params[:user_id])
    @user.approve!
    redirect_to users_path, notice: "管理員#{@user.name}權限提昇成功！"
  end

  def unapprove
    @user = User.find(params[:user_id])
    @user.unapprove!
    redirect_to users_path, notice: "#{@user.name}已不再是管理員"
  end
end
