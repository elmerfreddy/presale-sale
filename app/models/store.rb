class Store < ActiveRecord::Base
  default_scope { order(:name) }

  validates :name, :address, presence: true
end
