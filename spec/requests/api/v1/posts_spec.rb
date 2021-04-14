require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  let(:resource) { create(:post) }

  include_examples 'a resource with tags requests', 'posts'

  # Smoke test just to make sure we save content value
  describe "POST /api/v1/posts with content value" do
    before { post api_v1_posts_path, params: attributes }

    let!(:attributes) { { data: { id: nil, attributes: { title: 'Title', content: content }, tags: ['Today'] } } }
    let(:content) { 'Some content' }

    it 'creates resource and returns correct status code' do
      expect(json['data']['attributes']['content']).to eq(content)
      expect(response).to have_http_status(201)
    end
  end
end
