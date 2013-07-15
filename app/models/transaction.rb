class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :store

  has_many :details, dependent: :destroy
  accepts_nested_attributes_for :details, reject_if: :all_blank, allow_destroy: true

  def store_name
    store.present? ? store.name : ''
  end

  def user_name
    user.present? ? user.full_name : ''
  end
end
