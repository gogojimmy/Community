#encoding: utf-8
class Unit < ActiveRecord::Base
  attr_accessible :address, :building_id, :management_fee, :num, :pin
  validates_presence_of :address, :management_fee, :num, :pin
  belongs_to :building
  has_one :resident, class_name: 'User'

  def unit_num
    self.num + "號"
  end

  def resident_name
    self.resident.try(:name)
  end
end
