class User < ApplicationRecord
  # relations
  has_one :inventory
  has_one :shopping_list
  has_many :recipes
  has_many :to_be_cookeds

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$\z/,
                      message: "is not an e-mail address"
                    }

  validates :password,  presence: true,
                        length: {
                          minimum: 5,
                          message: "must be at least 5 characters"
                        }

  # devise methods
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
