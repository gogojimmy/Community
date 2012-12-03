#encoding: utf-8
class Resident < ActiveRecord::Base
  attr_accessible :bike_num, :car_num, :created_by, :name, :phone, :pid, :rent, :unit_id, :updated_by

  acts_as_commentable

  after_create :build_create_comment
  before_update :build_update_comment

  CAR_FEE = 200
  BIKE_FEE = 100

  has_many :payments
  belongs_to :unit

  scope :current_residents, where("unit_id IS NOT NULL")
  scope :idle, where("unit_id IS NULL")

  delegate :num, :address, :building, :pin, to: :unit, allow_nil: true, prefix: true

  def build_payment(user)
    payment = self.payments.build
    payment.management_fee = self.unit.management_fee
    payment.car_fee = CAR_FEE if self.car_num.present?
    payment.bike_fee = BIKE_FEE if self.bike_num.present?
    payment.created_by = user.id
    payment.save
  end

  def building_unit
    return if self.unit.nil?
    "#{self.unit.building.building_name}-#{self.unit.unit_num}"
  end

  def unit_address
    self.unit.try(:address)
  end

  def management_fee
    self.unit.try(:management_fee)
  end

  def created_user
    User.find(self.created_by)
  end

  def updated_user
    User.find(self.updated_by)
  end

  protected

  def build_create_comment
    comment = Comment.build_from(self, self.created_by, "#{self.created_user.name}建立了#{self.name}")
    comment.save
  end

  def build_update_comment
    comment = Comment.build_from(self, self.updated_by, "#{self.updated_user.name}更新了#{self.name}</br>更新內容：#{self.changes}")
    comment.save
  end

end
