require 'rails_helper'

describe SectionsController, type: :api do
  context 'GET /sections' do
    let!(:sections) { create_list(:section, 3) }

    before(:each) do
      get '/sections'
      @data = JSON.parse(last_response.body)
    end

    it 'returns an array of sections' do
      expect(last_response.status).to eq(200)
      expect(@data).to be_an_instance_of(Array)
      expect(@data.count).to eq(3)
    end

    it 'contains section data' do
      names = sections.map(&:name)
      @data.each do |section|
        expect(names).to include(section['name'])
      end
    end
  end

  context 'GET /sections/:id' do
    let!(:section) { create(:section) }

    before(:each) do
      get "/sections/#{section.id}"
      @data = JSON.parse(last_response.body)
    end

    it 'returns successfully' do
      expect(last_response.status).to eq(200)
    end

    it 'contains the right section' do
      expect(@data['name']).to eq(section.name)
      expect(@data['id']).to eq(section.id)
    end

    it 'fails gracefully when section is not found' do
      get '/sections/0'
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(404)
      expect(data.key?('errors')).to be_truthy
    end

    it 'fails gracefully when handed nonsense' do
      get '/sections/garbage'
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(404)
      expect(data.key?('errors')).to be_truthy
    end
  end

  context 'GET /sections/:id/titles' do
    let!(:section) { create(:section_with_titles) }

    before(:each) do
      get "/sections/#{section.id}/titles"
      @data = JSON.parse(last_response.body)
    end

    it 'returns an array of titles' do
      tc = section.titles.count
      expect(last_response.status).to eq(200)
      expect(@data).to be_an_instance_of(Array)
      expect(@data.count).to eq(tc)
    end

    it 'contains section data' do
      names = section.titles.map(&:title)
      @data.each do |title|
        expect(names).to include(title['title'])
      end
    end
  end
end
