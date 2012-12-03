#encoding: utf-8
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password, :password_confirmation, :remember_me, :email, :name, :phone, :pid

  validates_presence_of :name, :phone, :pid

end
