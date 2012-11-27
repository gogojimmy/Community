#encoding: utf-8
class ResidentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:admin]
      @residents = User.admins
    else
      @residents = User.current_residents.paginate(page: params[:page])
    end
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
    if @resident.update_attributes(params[:user])
      redirect_to resident_path(@resident), notice: "成功更新了#{@resident.name}的資料"
    end
  end
end
