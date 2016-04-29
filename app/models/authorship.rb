class Authorship < ApplicationRecord
  belongs_to :author
  belongs_to :title
end
