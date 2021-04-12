require 'rails_helper'

RSpec.describe 'Api::V1::Tags', type: :request do
  let(:tag) { create(:tag) }
  let(:tag_attributes) { { data: { id: nil, attributes: { title: title } } } }

  # Test suite for GET /api/v1/tags
  describe 'GET /api/v1/tags' do
    before { get api_v1_tags_path }

    it 'returns tags and correct status code' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /api/v1/tags
  describe 'POST /api/v1/tags' do
    before { post api_v1_tags_path, params: tag_attributes }
    let(:title) { 'Some Title' }

    context 'when request is valid' do
      it 'creates a tag and returns correct status code' do
        expect(json['data']['attributes']['title']).to eq(title)
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is not valid' do
      let!(:title) { nil }

      it 'returns unprocessable entity status code' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PATCH /api/v1/tags
  describe 'PATCH /api/v1/tags/:id' do
    before { patch api_v1_tag_path(id), params: tag_attributes }

    let(:title) { 'Some Title' }

    context 'when record exists' do
      let(:id) { tag.id }

      it 'updates the record with title field and returns correct status code' do
        expect(tag.reload.title).to eq(title)
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:id) { 0 }

      it 'returns unprocessable entity status code and resource not found error message' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
