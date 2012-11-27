class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password, :password_confirmation, :remember_me, :email, :role, :name, :phone, :car_num, :bike_num, :rent, :pid, :unit_id

  belongs_to :unit
  validates_presence_of :name, :phone, :pid

  ROLES = { 'system' => 100, 'operator' => 10, 'resident' => 1 }

  def has_permission?(permission)
    ROLES[self.role] >= ROLES[permission.to_s]
  end

  def self.current_residents
    where(:unit_id != nil)
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

end
