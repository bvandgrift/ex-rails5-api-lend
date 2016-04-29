FactoryGirl.define do
  factory :section do
    name { FFaker::NatoAlphabet.code }
  end

  factory :section_with_titles, parent: :section do
    after(:create) do |s|
      create_list(:title, 3).each do |t|
        t.sections << s
      end
    end
  end
end
