class DetailSerializer < ActiveModel::Serializer
  attributes :id, :quantity
  has_one :product
  has_one :transaction
end
