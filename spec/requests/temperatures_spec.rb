require 'rails_helper'

RSpec.describe "Temperatures", type: :request do
  before :each do
    MandrillMailer.deliveries.clear
  end

  let!(:tmp1) { Temperature.create(value: 37.5) }
  let!(:tmp2) { Temperature.create(value: 37.5, created_at: 1.day.ago) }
  let!(:tmp3) { Temperature.create(value: 37.5, created_at: 2.days.ago) }
  let!(:tmp4) { Temperature.create(value: 37.5, created_at: 3.days.ago) }
  let!(:tmp5) { Temperature.create(value: 37.5, created_at: 4.day.ago) }

  describe "GET /list" do
    it 'returns list of tmps' do
      get '/list'
      expect(response.status).to eq 200
      expect(JSON.parse(response.body).size).to eq 5
    end

    it 'returns list of tmps > since' do
      get '/list', params: {since: 3.days.ago.to_s}
      expect(response.status).to eq 200
      expect(JSON.parse(response.body).size).to eq 4
    end

    it 'returns list of tmps < till' do
      get '/list', params: {till: 1.day.ago}
      expect(response.status).to eq 200
      expect(JSON.parse(response.body).size).to eq 4
    end

    it 'returns list of since < tmps < till' do
      get '/list', params: {since: 3.days.ago, till: 1.day.ago}
      expect(response.status).to eq 200
      expect(JSON.parse(response.body).size).to eq 3
    end
  end

  describe "POST /temperature" do
    it 'returns 200 status for valid temp' do
      post '/temperature', params: {value: 10}
      expect(response.status).to eq 200
    end

    it 'returns 400 status for invalid temp' do
      post '/temperature', params: {}
      expect(response.status).to eq 400
      expect(response.body).to eq "{\"value\":[\"can't be blank\"]}"
    end
  end

  describe "POST /offset" do
    it 'returns 200 status for valid temp' do
      post '/offset', params: {value: 10}
      expect(response.status).to eq 200
    end

    it 'returns 400 status for invalid temp' do
      post '/offset', params: {}
      expect(response.status).to eq 400
      expect(response.body).to eq "{\"value\":[\"can't be blank\"]}"
    end
  end
end
