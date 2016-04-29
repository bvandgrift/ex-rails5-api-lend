class Title < ApplicationRecord
  has_many :section_assignments, dependent: :destroy
  has_many :authorships, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :sections, through: :section_assignments
  has_many :authors, through: :authorships

  validates :title, presence: true
end
