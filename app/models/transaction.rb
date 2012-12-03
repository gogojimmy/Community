#encoding: utf-8
class Transaction < ActiveRecord::Base
  attr_accessible :amount, :description, :from_account_id, :to_account_id, :transaction_type_id, :created_by, :updated_by, :from_account, :to_account, :transaction_type

  after_create :build_create_comment
  after_update :build_update_comment
  acts_as_commentable

  belongs_to :to_account, class_name: 'Account', foreign_key: 'to_account_id'
  belongs_to :from_account, class_name: 'Account', foreign_key: 'from_account_id'
  belongs_to :transaction_type
  belongs_to :invoice

  scope :today_records, where("DATE(created_at) = DATE(?)", Time.now)

  def self.belongs_to_account(account)
    where("to_account_id = #{account.id} OR from_account_id = #{account.id}")
  end

  def created_user
    User.find(self.created_by)
  end

  def updated_user
    User.find(self.updated_by)
  end

  def do_withdraw(user)
    self.from_account.withdraw(self.amount, user)
    self.created_by = user.id
    self.save!
  end

  def do_deposit(user)
    self.to_account.deposit(self.amount, user)
    self.created_by = user.id
    save!
  end

  def do_transfer(user)
    Account.transfer(self.from_account, self.to_account, self.amount, user)
    self.created_by = user.id
    save!
  end

  protected

  def build_create_comment
    comment = Comment.build_from(self, self.created_by, "#{self.created_user.name}建立了這筆交易")
    comment.save
  end

  def build_update_comment
    comment = Comment.build_from(self, self.updated_by, "#{self.updated_user.name}更新了這筆交易</br>更新內容：#{self.changes}")
    comment.save
  end

end
