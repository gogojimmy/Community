class Balance < ActiveRecord::Base
  attr_accessible :amount, :account_id
  belongs_to :account
  belongs_to :user
end
