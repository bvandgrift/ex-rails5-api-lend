require 'rails_helper'

RSpec.describe Author, type: :model do
  # associations
  it { should have_many(:authorships) }
  it { should have_many(:titles).through(:authorships) }

  # validations
  it { should validate_presence_of(:name) }
end
