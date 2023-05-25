class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes, through: :recipes_foods
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 250 }
  validates :measurement_unit, length: { maximum: 250 }
  validates :price, comparison: { greater_than: 0 }
  validates :quantity, comparison: { greater_than: 0 }
end
