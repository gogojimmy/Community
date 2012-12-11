class Balance < ActiveRecord::Base
  attr_accessible :amount, :account_id, :user
  belongs_to :account
  belongs_to :user
end
