#encoding: utf-8
class Building < ActiveRecord::Base
  attr_accessible :name, :updated_by, :created_by
  has_many :units, dependent: :destroy
  validates_presence_of :name

  after_create :build_create_comment
  before_update :build_update_comment

  acts_as_commentable

  def building_name
    self.name + '棟'
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
