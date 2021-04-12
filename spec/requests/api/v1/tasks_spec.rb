require 'rails_helper'

RSpec.describe 'Api::V1::Tasks', type: :request do
  let(:task) { create(:task) }
  let(:task_attributes) { { data: { id: nil, attributes: { title: title }, tags: ['Today'] } } }

  # Test suite for GET /api/v1/tasks
  describe 'GET /api/v1/tasks' do
    before { get api_v1_tasks_path }

    it 'returns tasks and correct status code' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/tasks/1
  describe 'GET /api/v1/tasks/:id' do
    before { get api_v1_tasks_path(task.id) }

    it 'returns task and correct status code' do
      expect(json['data'][0]['attributes']['title']).to eq(task.title)
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /api/v1/tasks
  describe 'POST /api/v1/tasks' do
    before { post api_v1_tasks_path, params: task_attributes }
    let(:title) { 'Some Title' }

    context 'when request is valid' do
      it 'creates a task and correct status code' do
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

  # Test suite for PATCH /api/v1/tasks
  describe 'PATCH /api/v1/tasks/:id' do
    before { patch api_v1_task_path(id), params: task_attributes }

    let(:title) { 'Some Title' }

    context 'when record exists' do
      let(:id) { task.id }

      it 'updates the record with title field and returns correct status code' do
        expect(task.reload.title).to eq(title)
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:id) { 0 }

      it 'returns unprocessable entity status code and resource not found error message' do
        expect(response).to have_http_status(422)

        expect(json['errors'][0]['detail']).to match(
          I18n.t(:not_found, scope: %i[activemodel errors models resource_with_tag attributes base])
        )
      end
    end
  end

  # Test suite for DELETE /api/v1/tasks/1
  describe 'DELETE /api/v1/tasks/:id' do
    before { delete api_v1_task_path(task.id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
