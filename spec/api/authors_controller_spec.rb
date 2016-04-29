require 'rails_helper'

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
