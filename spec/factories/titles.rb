FactoryGirl.define do
  factory :title do
    title FFaker::Movie.title
    after(:create) do |t|
      t.authors << create(:author)
    end
  end
end
