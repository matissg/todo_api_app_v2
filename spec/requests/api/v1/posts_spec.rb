require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  let(:resource) { create(:post) }
  let(:attributes) { { data: { id: nil, attributes: { title: title }, tags: ['Today'] } } }

  include_examples 'a resource with tags requests', 'posts'
end
