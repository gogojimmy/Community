#encoding: utf-8
class Building < ActiveRecord::Base
  attr_accessible :name
  has_many :units, dependent: :destroy
  validates_presence_of :name

  def building_name
    self.name + '棟'
  end
end
