class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :store_name, :products_count, :user_name, :total, :date
  has_many :details

  def date
    object.created_at.to_s :short
  end

  def store_name
    "#{ object.store_name }"
  end

  def products_count
    object.details_count
  end

  def user_name
    "#{ object.user_name }"
  end
end
