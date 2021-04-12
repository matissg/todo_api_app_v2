require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let(:task) { create(:task) }
  let(:task_id) { task.id }
  let(:task_attributes) { { data: { id: nil, attributes: { title: title }, tags: ['Today'] } } }
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

  describe 'GET #show' do
    before { get :show, params: { id: task.to_param } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:title) { 'Some Task' }

      it 'creates a new Task and renders a JSON response with the new api/v1_task' do
        expect { post :create, params: task_attributes, session: valid_session }.to change(Task, :count).by(1)
        expect_json_response_keys
      end
    end

    context 'with invalid params' do
      let(:title) { nil }

      it 'renders a JSON response with errors for the new api/v1_task' do
        post :create, params: task_attributes, session: valid_session

        expect_json_response_with_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:title) { 'Some Task' }

      it 'updates the requested api/v1_task and renders a JSON response with the api/v1_task' do
        put :update,
            params: {
              data: { type: 'tasks', id: task_id, attributes: { title: 'Updated Task Title' } }, id: task_id, task: {}
            },
            session: valid_session
        task.reload

        expect_json_response_keys
        expect_json_response_with_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:title) { nil }

      it 'renders a JSON response with errors for the api/v1_task' do
        put :update,
            params: {
              data: { type: 'tasks', id: task_id, attributes: { title: title } }, id: task_id, task: {}
            },
            session: valid_session

        expect_json_response_with_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { create(:task) }

    it 'destroys the requested api/v1_task' do
      expect { delete :destroy, params: { id: Task.first.id }, session: valid_session }.to change(Task, :count).by(-1)
    end
  end
end
