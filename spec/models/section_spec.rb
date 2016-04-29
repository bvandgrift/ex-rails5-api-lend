require 'rails_helper'

RSpec.describe Section, type: :model do
  # associations
  it { should have_many(:section_assignments) }
  it { should have_many(:titles).through(:section_assignments) }

  # validations
  it { should validate_presence_of(:name) }
end
