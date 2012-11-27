module ApplicationHelper
  def currency(price)
    number_to_currency price, :precision => 0
  end
end
