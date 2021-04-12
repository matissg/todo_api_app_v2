require 'rails_helper'

RSpec.describe 'Api::V1::Tasks', type: :request do
  let(:resource) { create(:task) }
  let(:attributes) { { data: { id: nil, attributes: { title: title }, tags: ['Today'] } } }

  include_examples 'a resource with tags requests', 'tasks'
end
