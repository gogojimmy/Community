#encoding: utf-8
class UnitsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_building

  def edit
    @unit = @building.units.find(params[:id])
  end

  def update
    @unit = @building.units.find(params[:id])
    @unit.updated_by = current_user

    if params[:unit][:resident_pid].present?
      @unit.resident = User.find_by_pid(params[:unit][:resident_pid])
    end

    if @unit.update_attributes(params[:unit].slice(:num,
                                                   :address,
                                                   :pin,
                                                   :management_fee))

      redirect_to buildings_path, notice: "成功更新單位"
    else
      render :edit
    end
  end

  def new
    @unit = @building.units.build
  end

  def create
    @unit = @building.units.build(params[:unit].slice(:num,
                                                      :address,
                                                      :pin,
                                                      :management_fee))

    @unit.created_by = current_user

    if params[:unit][:resident_pid].present?
      @unit.resident = User.find_by_pid(params[:unit][:resident_pid])
    end

    if @unit.save
      redirect_to buildings_path, notice: '成功建立單位'
    else
      render :new
    end
  end

  def destroy
    @unit = @building.units.find(params[:id])
    @unit.destroy
    redirect_to buildings_path, notice: '單位刪除成功'
  end

  protected

  def find_building
    @building = Building.find(params[:building_id])
  end
end
