class Style < ActiveRecord::Base
  has_many :recipe_styles
  has_many :recipes, through: :recipe_styles
  validates :name, presence: true, length {minimun: 2, maximun: 25 }
end