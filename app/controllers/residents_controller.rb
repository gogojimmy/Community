#encoding: utf-8
class ResidentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @residents = Resident.paginate(page: params[:page])
  end

  def show
    @resident = Resident.find(params[:id])
  end

  def new
    @resident = Resident.new
  end

  def create
    @resident = Resident.new(params[:resident])
    @resident.created_by = current_user

    if @resident.save
      redirect_to resident_path(@resident), notice: "#{@resident.name}建立成功！"
    else
      render :new, notice: @resident.errors
    end
  end

  def edit
    @resident = Resident.find(params[:id])
  end

  def update
    @resident = Resident.find(params[:id])
    @resident.updated_by = current_user

    if @resident.update_attributes(params[:user])
      redirect_to resident_path(@resident), notice: "成功更新了#{@resident.name}的資料"
    end
  end
end
