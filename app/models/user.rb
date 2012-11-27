class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password, :password_confirmation, :remember_me, :email, :role, :name, :phone, :car_num, :bike_num, :rent, :pid, :cell_id

  belongs_to :cell
  validates_presence_of :name, :phone, :pid

  ROLES = { 'system' => 100, 'operator' => 10, 'resident' => 1 }

  def has_permission?(permission)
    ROLES[self.role] >= ROLES[permission.to_s]
  end

  def self.current_residents
    where(:cell_id != nil)
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
