#encoding: utf-8
class Payment < ActiveRecord::Base
  attr_accessible :bike_fee, :car_fee, :created_by, :management_fee, :paid_date, :updated_by, :resident_id, :transactions_attributes, :invoice

  belongs_to :resident
  belongs_to :invoice
  has_many :transactions
  accepts_nested_attributes_for :transactions,
                                :reject_if => lambda { |a| a[:amount].blank? }

  after_create :build_create_comment
  before_update :build_update_comment

  delegate :num, to: :invoice, allow_nil: true, prefix: true

  scope :paid_records, where('paid_date IS NOT NULL')
  scope :unpaid_records, where('paid_date IS NULL')

  acts_as_commentable

  def self.create_this_month_fee(user)
    Resident.current_residents.each do |resident|
      resident.build_payment(user)
    end
  end

  def month
    I18n.l self.created_at.beginning_of_month, format: '%B'
  end

  def pay(invoice, user)
    update_attributes(paid_date: Time.now,
                      invoice: invoice,
                      updated_by: user.id)
    save!
  end

  def paid?
    self.paid_date?
  end

  def created_user
    User.find(self.created_by)
  end

  def updated_user
    User.find(self.updated_by)
  end

  def total_fee
    management_fee + car_fee + bike_fee
  end

  protected

  def build_create_comment
    comment = Comment.build_from(self, self.created_by, "#{self.created_user.name}產生本月費用共$#{total_fee}")
    comment.save
  end

  def build_update_comment
    comment = Comment.build_from(self, self.updated_by, "#{self.updated_user.name}完成了這次繳費")
    comment.save
  end

end
