#encoding: utf-8
class Invoice < ActiveRecord::Base
  attr_accessible :amount, :invoice_type, :num, :resident

  INVOICE_TYPE = %w{ 住戶收據 一般收據 }
  has_many :payments
  belongs_to :resident

  before_create :generate_serial_num

  def self.pay_and_generate(user, resident, account, payments)
    months = payments.map(&:month)
    amount = payments.map(&:total_fee).sum

    invoice = create(amount: amount, invoice_type: '住戶收據', resident: resident)

    transaction = Transaction.new(amount: amount,
                                  to_account: account,
                                  transaction_type: TransactionType.management_fee,
                                  description: "#{resident.name}的#{months}的管理費收入")
    if transaction.do_deposit(user)
      payments.each do |payment|
        payment.pay(invoice, user)
      end
    else
      invoice.destroy
    end
    invoice
  end

  private

  def generate_serial_num
    self.num = serial_num
  end

  def serial_num
    "#{Time.zone.now.strftime("%Y%m%d")}%.4d" % (Invoice.this_month_records_count + 1)
  end

  def self.this_month_records_count
    where('created_at > ?', (Date.today - 1.month).beginning_of_month).count
  end
end
