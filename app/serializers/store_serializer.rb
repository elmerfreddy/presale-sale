class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :owner, :address, :latitude, :longitude
end
