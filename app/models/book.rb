class Book < ApplicationRecord
  belongs_to :title

  validates :title, presence: true
end
