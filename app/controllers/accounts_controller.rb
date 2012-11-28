#encoding: utf-8
class AccountsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @accounts = Account.paginate(page: params[:page])
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(params[:account])
    @account.created_by = current_user.id
    if @account.save
      redirect_to accounts_path, notice: "成功建立了#{@account.name}"
    else
      render :new
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account].slice(:name),
                                  updated_by: current_user.id)
      redirect_to accounts_path, notice: "成功更新了#{@account.name}"
    else
      render :edit
    end
  end

  def destroy
    @account = Account.find(params[:id])
    name = @account.name
    @account.destroy
    redirect_to accounts_path, notice: "#{name}已被刪除"
  end
end
