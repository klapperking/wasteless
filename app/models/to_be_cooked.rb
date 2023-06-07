class ToBeCooked < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :recipe

  # validations
  validates :user, presence: true
  validates :recipe, presence: true
end
