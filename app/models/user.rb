#encoding: utf-8
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password, :password_confirmation, :remember_me, :email, :name, :phone, :pid, :approved

  validates_presence_of :name, :phone, :pid
  has_many :balances

  scope :admins, where(approved: true)
  scope :waiting_for_reviewed, where(approved: false)

  def approve!
    self.update_attribute('approved', true)
  end

  def unapprove!
    self.update_attribute('approved', false)
  end

end
