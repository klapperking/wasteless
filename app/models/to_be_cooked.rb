class ToBeCooked < ApplicationRecord
  belongs_to :user
  belongs_to :recipes
end
