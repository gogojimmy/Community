#encoding: utf-8
class Unit < ActiveRecord::Base
  attr_accessible :address, :building_id, :management_fee, :num, :pin, :updated_by, :created_by
  validates_presence_of :address, :management_fee, :num, :pin
  belongs_to :building
  has_one :resident
  delegate :name, to: :resident, allow_nil: true, prefix: true

  acts_as_commentable

  after_create :build_create_comment
  before_update :build_update_comment

  def unit_num
    self.num + "樓"
  end

  def created_user
    User.find(self.created_by)
  end

  def updated_user
    User.find(self.updated_by)
  end

  protected

  def build_create_comment
    comment = Comment.build_from(self, self.created_by, "#{self.created_user.name}建立了#{self.address}")
    comment.save
  end

  def build_update_comment
    comment = Comment.build_from(self, self.updated_by, "#{self.updated_user.name}更新了#{self.address}</br>更新內容：#{self.changes}")
    comment.save
  end
end
