require 'rails_helper'

RSpec.describe Book, type: :model do
  # associations
  it { should belong_to(:title) }

  # validations
  it { should validate_presence_of(:title) }
end
