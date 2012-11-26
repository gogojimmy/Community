class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :username, :password, :password_confirmation, :remember_me, :email, :role, :name, :phone, :car_num, :bike_num, :rent, :pid, :cell_id

  ROLES = { 'system' => 100, 'operator' => 10, 'resident' => 1 }

  def has_permission?(permission)
    ROLES[self.role] >= ROLES[permission.to_s]
  end
end
