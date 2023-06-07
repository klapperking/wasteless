class User < ApplicationRecord
  # devise methods
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # callbacks
  after_validation :create_inventory, :create_shopping_list

  # relations
  has_one :inventory, dependent: :destroy
  has_one :shopping_list, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :to_be_cookeds, dependent: :destroy

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

  private

  def create_inventory
    self.inventory = Inventory.new
  end

  def create_shopping_list
    self.shopping_list = ShoppingList.new(name: "#{first_name}'s Shopping List")
  end
end
