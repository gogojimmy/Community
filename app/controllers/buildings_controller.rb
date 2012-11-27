#encoding: utf-8
class BuildingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @buildings = Building.paginate(page: params[:page])
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(params[:building])
    if @building.save
      redirect_to buildings_path, notice: "成功建立#{@building.name}"
    else
      render :new
    end
  end

  def edit
    @building = Building.find(params[:id])
  end

  def update
    @building = Building.find(params[:id])
    if @building.update_attributes(params[:building])
      redirect_to buildings_path, notice: "#{@building.name}更新成功"
    else
      render :edit
    end
  end
end
