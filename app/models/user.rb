#encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password, :password_confirmation, :remember_me, :email, :role, :name, :phone, :car_num, :bike_num, :rent, :pid, :unit_id, :updated_by, :created_by

  belongs_to :unit
  has_many :payments

  validates_presence_of :name, :phone, :pid
  before_create :build_create_comment
  before_update :build_update_comment

  acts_as_commentable

  ROLES = { 'system' => 100, 'operator' => 10, 'resident' => 1 }
  CAR_FEE = 200
  BIKE_FEE = 100

  def has_permission?(permission)
    ROLES[self.role] >= ROLES[permission.to_s]
  end

  def self.current_residents
    where("unit_id IS NOT NULL")
  end

  def build_payment(user)
    payment = self.payments.build
    payment.management_fee = self.unit.management_fee
    payment.car_fee = CAR_FEE if self.car_num
    payment.bike_fee = BIKE_FEE if self.bike_num
    payment.created_by = user.id
    payment.save
  end

  def unit_address
    self.unit.try(:address)
  end

  def management_fee
    self.unit.try(:management_fee)
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
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
