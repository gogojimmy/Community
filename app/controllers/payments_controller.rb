#encoding: utf-8
class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @payments = Payment.paginate(page: params[:page])
  end

  def new
    Payment.create_this_month_fee(current_user)
    redirect_to payments_path, notice: '本月費用已產生成功'
  end
end
