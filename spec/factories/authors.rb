FactoryGirl.define do
  factory :author do
    name { FFaker::Name.name }
  end

  factory :author_with_titles, parent: :author do
    after(:create) do |a|
      build_list(:title, 3).each do |t|
        a.titles << t
      end
    end
  end
end
