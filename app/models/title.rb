class Title < ApplicationRecord
  has_many :section_assignments
  has_many :authorships
  has_many :sections, through: :section_assignments
  has_many :authors, through: :authorships
  has_many :books

  validates :title, presence: true
end
