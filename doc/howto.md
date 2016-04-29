# HOWTO

This project is intended to be an exemplar of the rails5 api +
devise_token_auth structure. It was built as follows:

## Create Rails

Grab edge rails:

```bash
git clone git://github.com/rails/rails.git
cd rails
bundle
bundle exec railties/exe/rails new ~/path/to/appname --api --edge
cd ~/path/to/appname
```

## Add Basic Framework

Add the following gems: grape, rspec-rails, rack-test, puma, simplecov,
shoulda-matchers, ffaker, factory_girl_rails, rubocop, and then 
`bundle install`.

## Add Models and Specs

Using either `rails g model` or proceeding manually, create the models. In this
case, Title, Author, Section, and Book:

```bash
bin/rails g scaffold author name olid:string:uniq bio:text 
bin/rails g scaffold title title olid:string:uniq
bin/rails g scaffold section name
bin/rails g scaffold book title:references
bin/rails g model section_assignment title:references section:references
bin/rails g model authorships author:references title:references
bin/rails db:create
bin/rails db:migrate
```

Using shoulda-matchers, create specs for the relationships and validations (in
`spec/models`), and create factories (in `spec/factories`) as needed, one factory
file for each model.

For example:

```ruby
RSpec.describe Author, type: :model do
  # associations
  it { should have_many(:authorships) }
  it { should have_many(:titles).through(:authorships) }

  # validations
  it { should validate_presence_of(:name) }
end
```

## Add API specs and API

Create a `spec/api` directory, and add api-focused controller
tests. REST-type controller actions have been created for you.

It's handy to include `spec/support` in your `spec/rails_helper.rb` file.
Dir[Rails.root.join("spec/support/\*\*/\*.rb")].each {|f| require f}

This'll let you do something like this, in `spec/support/api_helper.rb`

```ruby
module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end

RSpec.configure do |config|
  config.include ApiHelper, :type=>:api #apply to all spec for apis folder
end
```

You'll also want to create some factories:

```ruby
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
```

Your api tests should be straightforward, and should be marked as the :api type:

```ruby
describe AuthorsController, type: :api do
  context 'GET /authors' do
    let!(:authors) { create_list(:author, 3) }

    before(:each) do
      get '/authors'
      @data = JSON.parse(last_response.body)
    end

    it 'returns an array of authors' do
      expect(last_response.status).to eq(200)
      expect(@data).to be_an_instance_of(Array)
      expect(@data.count).to eq(3)
    end

    it 'contains author data' do
      names = authors.map(&:name)
      @data.each do |author|
        expect(names).to include(author['name'])
      end
    end
  end

  context 'GET /authors/:id' do
    let!(:author) { create(:author) }

    before(:each) do
      get "/authors/#{author.id}"
      @data = JSON.parse(last_response.body)
    end

    it 'returns successfully' do
      expect(last_response.status).to eq(200)
    end

    it 'contains the right author' do
      expect(@data['name']).to eq(author.name)
      expect(@data['id']).to   eq(author.id)
    end

    it 'fails gracefully when author is not found' do
      get '/authors/0'
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(404)
      expect(data.key?('errors')).to be_truthy
    end

    it 'fails gracefully when handed nonsense' do
      get '/authors/garbage'
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(404)
      expect(data.key?('errors')).to be_truthy
    end
  end
end
```
Ensure all tests pass and coverage is good before proceeding.

## Up Next: Add Devise and Devise Token Auth
