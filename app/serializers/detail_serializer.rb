class DetailSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :product_name, :price, :total
end
