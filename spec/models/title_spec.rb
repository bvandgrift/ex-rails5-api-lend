require 'rails_helper'

RSpec.describe Title, type: :model do
  # associations
  it { should have_many(:authorships) }
  it { should have_many(:authors).through(:authorships) }
  it { should have_many(:section_assignments) }
  it { should have_many(:sections).through(:section_assignments) }
  it { should have_many(:books) }

  # validations
  it { should validate_presence_of(:title) }
end
