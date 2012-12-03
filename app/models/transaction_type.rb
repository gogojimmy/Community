#encoding: utf-8
class TransactionType < ActiveRecord::Base
  attr_accessible :description, :name, :self_type

  TYPES = %w{ 收入 支出 }

  scope :deposit_only, where(self_type: '收入')
  scope :withdraw_only, where(self_type: '支出')

  def self.management_fee
    where(name: '管理費收入').first
  end
end
