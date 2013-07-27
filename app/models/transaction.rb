class Transaction < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  belongs_to :user
  belongs_to :store

  has_many :details, dependent: :destroy
  accepts_nested_attributes_for :details, reject_if: :all_blank, allow_destroy: true

  def details_count
    details.count
  end

  def store_name
    store.present? ? store.name : ''
  end

  def total
    details.inject(0.0) { |s, d| s + d.total }
  end

  def user_name
    user.present? ? user.full_name : ''
  end
end
