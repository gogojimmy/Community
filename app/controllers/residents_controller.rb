#encoding: utf-8
class ResidentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @residents = User.paginate(page: params[:page])
  end

  def show
    @resident = User.find(params[:id])
  end

  def new
    @resident = User.new
  end

  def create
    @resident = User.new(params[:user])
    @resident.password = Devise.friendly_token.first(6)
    @resident.created_by = current_user

    if @resident.save
      redirect_to resident_path(@resident), notice: "#{@resident.name}建立成功！"
    else
      render :new, notice: @resident.errors
    end
  end

  def edit
    @resident = User.find(params[:id])
  end

  def update
    @resident = User.find(params[:id])
    @resident.updated_by = current_user

    if @resident.update_attributes(params[:user])
      redirect_to resident_path(@resident), notice: "成功更新了#{@resident.name}的資料"
    end
  end
end
