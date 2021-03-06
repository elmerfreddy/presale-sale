class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :registerable,:recoverable,
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable,
         :token_authenticatable

  has_many :transactions

  def full_name
    email
  end

  def name
    full_name
  end
end
