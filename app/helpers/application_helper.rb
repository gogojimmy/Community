#encoding: utf-8
module ApplicationHelper
  def currency(price)
    number_to_currency price, :precision => 0
  end

  def show_transaction_type_badge(transaction)
    if transaction.from_account.present? && transaction.to_account.present?
      content_tag(:span, "轉帳", :class => 'label label-info')
    elsif transaction.transaction_type.self_type == '收入'
      content_tag(:span, "收入", :class => 'label label-success')
    else
      content_tag(:span, "支出", :class => 'label label-important')
    end
  end
end
