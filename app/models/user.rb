class User < ApplicationRecord
  has_one :inventory
  has_one :shopping_list
  has_many :recipes

  has_many :to_be_cookeds

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
