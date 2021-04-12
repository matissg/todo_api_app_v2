require 'rails_helper'

RSpec.describe Api::V1::TagsController, type: :controller do
  let(:tag) { create(:tag) }
  let(:tag_id) { tag.id }
  let(:tag_attributes) { { data: { id: nil, attributes: { title: title } } } }
  let(:valid_session) { {} }

  describe 'GET #index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'JSON body response contains expected attributes' do
      expect_json_response_keys
    end
  end

  describe 'POST #create' do
    let(:title) { 'Today' }

    context 'with valid params' do
      it 'creates a new Task' do
        expect { post :create, params: tag_attributes, session: valid_session }.to change(Tag, :count).by(1)
      end

      it 'renders a JSON response with the new api/v1_tag' do
        post :create, params: tag_attributes, session: valid_session
        expect_json_response_keys
      end
    end

    context 'with invalid params' do
      let(:title) { nil }

      it 'renders a JSON response with errors for the new api/v1_tag' do
        post :create, params: tag_attributes, session: valid_session

        expect_json_response_with_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:title) { 'Updated Title' }

      it 'updates the requested api/v1_tag and renders a JSON response' do
        put :update,
            params: {
              data: { type: 'tags', id: tag_id, attributes: { title: title } }, id: tag_id, tag: {}
            },
            session: valid_session
        tag.reload

        expect_json_response_keys
        expect_json_response_with_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:title) { nil }

      it 'renders a JSON response with errors for the api/v1_tag' do
        put :update,
            params: {
              data: { type: 'tags', id: tag_id, attributes: { title: title } }, id: tag_id, tag: {}
            },
            session: valid_session

        expect_json_response_with_status(:unprocessable_entity)
      end
    end
  end
end
