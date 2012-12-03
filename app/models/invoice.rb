#encoding: utf-8
class Invoice < ActiveRecord::Base
  attr_accessible :amount, :invoice_type, :num, :resident

  INVOICE_TYPE = %w{ 住戶收據 一般收據 }
  has_many :payments
  belongs_to :resident

  before_create :generate_serial_num

  def self.pay_and_generate(user, resident, account, payments)
    amount = payments.map(&:total_fee).sum

    invoice = create(amount: amount, invoice_type: '住戶收據', resident: resident)

    payments.each do |payment|
      management_fee_transaction = Transaction.new(amount: payment.management_fee,
                                                   to_account: account,
                                                   transaction_type: TransactionType.management_fee,
                                                   description: "#{resident.name}#{payment.month}的管理費收入")
      management_fee_transaction.do_deposit(user)
      comment = Comment.build_from(resident, user, "#{resident.name}繳交管理費共$#{payment.management_fee}")
      comment.save
      if payment.car_fee != 0
        car_fee_transaction = Transaction.new(amount: payment.car_fee,
                                              to_account: account,
                                              transaction_type: TransactionType.car_fee,
                                              description: "#{resident.name}#{payment.month}的汽車清潔費收入")
        car_fee_transaction.do_deposit(user)
        comment = Comment.build_from(resident, user, "#{resident.name}繳交汽車清潔費共$#{payment.car_fee}")
        comment.save
      end

      if payment.bike_fee != 0
        bike_fee_transaction = Transaction.new(amount: payment.bike_fee,
                                               to_account: account,
                                               transaction_type: TransactionType.bike_fee,
                                               description: "#{resident.name}#{payment.month}的機車清潔費收入")
        bike_fee_transaction.do_deposit(user)
        comment = Comment.build_from(resident, user, "#{resident.name}繳交機車清潔費共$#{payment.bike_fee}")
        comment.save
      end
      payment.pay(invoice, user)
    end

    invoice
  end

  private

  def generate_serial_num
    self.num = serial_num
  end

  def serial_num
    "#{Time.zone.now.strftime("%Y%m")}%.4d" % (Invoice.this_month_records_count + 1)
  end

  def self.this_month_records_count
    where('created_at > ?', (Date.today - 1.month).beginning_of_month).count
  end
end
