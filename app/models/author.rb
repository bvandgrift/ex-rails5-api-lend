class Author < ApplicationRecord
  has_many :authorships, dependent: :destroy
  has_many :titles, through: :authorships

  validates :name, presence: true
end
