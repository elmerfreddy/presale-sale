class Product < ActiveRecord::Base
  default_scope { order(:name) }

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
