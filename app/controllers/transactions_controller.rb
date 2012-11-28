#encoding: utf-8
class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @transaction = Transaction.new
  end

  def withdraw
    @transaction = Transaction.new(params[:transaction])
    if @transaction.do_withdraw(current_user)
      redirect_to transactions_path, notice: '交易成功'
    else
      render :new
    end
  end

  def deposit
    @transaction = Transaction.new(params[:transaction])
    if @transaction.do_deposit(current_user)
      redirect_to transactions_path, notice: '交易成功'
    else
      render :new
    end
  end

  def transfer
    @transaction = Transaction.new(params[:transaction])
    if @transaction.do_transfer(current_user)
      redirect_to transactions_path, notice: '交易成功'
    else
      render :new
    end
  end

  def index
    @transactions = Transaction.today_records
  end
end
