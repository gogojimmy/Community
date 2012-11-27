#encoding: utf-8
class Payment < ActiveRecord::Base
  attr_accessible :bike_fee, :car_fee, :created_by, :management_fee, :paid_date, :updated_by, :user_id

  belongs_to :resident, class_name: 'User', foreign_key: 'user_id'

  before_create :build_create_comment
  before_update :build_update_comment

  acts_as_commentable

  def self.create_this_month_fee(user)
    User.current_residents.each do |resident|
      resident.build_payment(user)
    end
  end

  def created_user
    User.find(self.created_by)
  end

  def updated_user
    User.find(self.updated_by)
  end

  def total_fee
    management_fee + car_fee + bike_fee
  end

  protected

  def build_create_comment
    comment = Comment.build_from(self, self.created_by, "#{self.created_user.name}產生本月費用共$#{total_fee}")
    comment.save
  end

  def build_update_comment
    comment = Comment.build_from(self, self.updated_by, "#{self.updated_user.name}完成了這次繳費")
    comment.save
  end

end
