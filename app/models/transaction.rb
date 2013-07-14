class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :store

  def store_name
    store.present? ? store.name : ''
  end

  def user_name
    user.present? ? user.full_name : ''
  end
end
