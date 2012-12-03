#encoding: utf-8
class Account < ActiveRecord::Base
  attr_accessible :balance, :created_by, :name, :updated_by

  validates_presence_of :name

  after_create :build_create_comment
  after_update :build_update_comment

  validates_numericality_of :balance, greater_than_or_equal_to: 0

  has_many :balances

  acts_as_commentable

  def checkout(user)
    self.balances.create(amount: self.balance,
                         user: user)
  end

  def transactions
    Transaction.belongs_to_account(self)
  end

  def self.cash_id
    self.find_by_name('現金').id
  end

  def created_user
    User.find(self.created_by)
  end

  def updated_user
    User.find(self.updated_by)
  end

  def withdraw(amount, user=nil)
    adjust_balance_and_save(-amount, user)
  end

  def deposit(amount, user=nil)
    adjust_balance_and_save(amount, user)
  end

  def self.transfer(from, to, amount, user=nil)
    transaction do
      from.withdraw(amount, user)
      to.deposit(amount, user)
    end
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

  private

  def adjust_balance_and_save(amount, user=nil)
    self.updated_by ||= user
    self.balance += amount
    save!
  end

end
