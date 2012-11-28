#encoding: utf-8
class TransactionTypesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @transaction_types = TransactionType.paginate(page: params[:page])
  end

  def new
    @transaction_type = TransactionType.new
  end

  def create
    @transaction_type = TransactionType.new(params[:transaction_type])
    @transaction_type.created_by = current_user.id
    if @transaction_type.save
      redirect_to transaction_types_path, notice: "建立成功"
    else
      render :new
    end
  end

  def edit
    @transaction_type = TransactionType.find(params[:id])
  end

  def update
    @transaction_type = TransactionType.find(params[:id])
    if @transaction_type.update_attributes(params[:transaction_type],
                                           updated_by: current_user.id)
      redirect_to transaction_types_path, notice: '更新成功'
    else
      render :edit
    end
  end
end
