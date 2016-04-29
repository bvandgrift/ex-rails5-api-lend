require 'rails_helper'

describe TitlesController, type: :api do

  context 'GET /titles' do
    let!(:titles) { create_list(:title, 3) }

    before(:each) do
      get '/titles'
      @data = JSON.parse(last_response.body)
    end

    it 'returns an array of titles' do
      expect(last_response.status).to eq(200)
      expect(@data).to be_an_instance_of(Array)
      expect(@data.count).to eq(3)
    end

    it 'contains title data' do
      names = titles.map(&:title)
      @data.each do |title|
        expect(names).to include(title['title'])
      end
    end
  end

  context 'GET /titles/:id' do
    let!(:title) { create(:title) }

    before(:each) do
      get "/titles/#{title.id}"
      @data = JSON.parse(last_response.body)
    end

    it 'returns successfully' do
      expect(last_response.status).to eq(200)
    end

    it 'contains the right title' do
      expect(@data['title']).to eq(title.title)
      expect(@data['id']).to eq(title.id)
    end

    it 'fails gracefully when title is not found' do
      get '/titles/0'
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(404)
      expect(data.key?('errors')).to be_truthy
    end

    it 'fails gracefully when handed nonsense' do
      get '/titles/garbage'
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(404)
      expect(data.key?('errors')).to be_truthy
    end
  end

  context 'POST /titles' do
    let!(:title) { build(:title) }
    let!(:author) { create(:author) }

    context 'when authorized' do
      before(:each) do
        post '/titles', title: { title: title.title,
                                 author_ids: [author.id] }
      end
      it 'creates a title' do
        expect(last_response.status).to eq(201)
      end

      it 'assigns authors' do
        data = JSON.parse(last_response.body)
        t = ::Title.find(data['id'])
        expect(t.authors.length).to eql(1)
      end
    end

    context 'when unauthorized' do
      it 'prevents unauthorized users' do
        pending('wait for auth')
        post '/titles', title: { title: title.title,
                                 author_ids: [author.id] }
        expect(last_response.status).to eq(403)
      end
    end
  end
end
