class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  has_many :todos, :dependent => :destroy
  validates :name, length: { maximum: 20 }, presence: true
  validates :email, length: { maximum: 50 }, presence: true, uniqueness: true
  validates :password, length: { maximum: 20 }, presence: true
  validates :image, presence: true

end
