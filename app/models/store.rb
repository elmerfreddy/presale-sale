class Store < ActiveRecord::Base
  validates :name, :owner, :address, presence: true
end
