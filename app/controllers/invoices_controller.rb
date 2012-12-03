class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  layout :resolve_layout

  def show
    @invoice = Invoice.find(params[:id])
  end

  def create
    @invoice = Invoice.pay_and_generate(current_user,
                                        Resident.find(params[:resident_id]),
                                        Account.find(params[:account_id]),
                                        Payment.find(params[:payment_ids]))
    redirect_to invoice_path(@invoice)
  end

  protected

  def resolve_layout
    case action_name
    when 'show'
      'print'
    else
      'application'
    end
  end
end
