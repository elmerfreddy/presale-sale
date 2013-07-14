class Detail < ActiveRecord::Base
  belongs_to :product
  belongs_to :transaction

  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
