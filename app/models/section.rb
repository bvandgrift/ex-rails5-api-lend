class Section < ApplicationRecord
  has_many :section_assignments
  has_many :sections, through: :section_assignments
  has_many :titles, through: :section_assignments

  validates :name, presence: true
end
