# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let!(:task) { create(:task, status: 'pending') }

  describe 'GET /tasks' do
    it 'returns a successful response' do
      get tasks_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(task.title)
    end
  end

  describe 'GET /tasks/:id' do
    it 'shows the task' do
      get task_path(task)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(task.title)
    end
  end

  describe 'GET /tasks/new' do
    it 'renders the new task form' do
      get new_task_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('New Task')
    end
  end

  describe 'GET /tasks/:id/edit' do
    it 'renders the edit task form' do
      get edit_task_path(task)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Edit Task')
    end
  end

  describe 'POST /tasks' do
    context 'with valid params' do
      let(:valid_params) { { task: { title: 'New Task', description: 'Test task', status: 'pending' } } }

      it 'creates a new task and redirects' do
        expect do
          post tasks_path, params: valid_params
        end.to change(Task, :count).by(1)

        expect(response).to redirect_to(tasks_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('notices.task.created'))
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { task: { title: '', description: 'Test', status: 'pending' } } }

      it 'does not create task and renders new' do
        expect do
          post tasks_path, params: invalid_params
        end.not_to change(Task, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('New Task')
      end
    end
  end

  describe 'PATCH /tasks/:id' do
    context 'with valid params' do
      let(:update_params) { { task: { title: 'Updated Title' } } }

      it 'updates the task and redirects' do
        patch task_path(task), params: update_params
        expect(task.reload.title).to eq('Updated Title')
        expect(response).to redirect_to(tasks_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('notices.task.updated'))
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { task: { title: '' } } }

      it 'does not update task and renders edit' do
        patch task_path(task), params: invalid_params
        expect(task.reload.title).not_to eq('')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Edit Task')
      end
    end
  end

  describe 'DELETE /tasks/:id' do
    it 'destroys the task and redirects' do
      expect do
        delete task_path(task)
      end.to change(Task, :count).by(-1)

      expect(response).to redirect_to(tasks_path)
      follow_redirect!
      expect(response.body).to include(I18n.t('notices.task.deleted'))
    end
  end

  # --------------------------
  # Shared example: update_status
  # --------------------------
  shared_examples 'status update' do |format, status_param, expected_status, success:, flash_key: nil|
    it "#{success ? 'updates' : 'does not update'} status via #{format}" do
      patch update_status_task_path(task, format: format), params: { status: status_param }
      task.reload
      expect(task.status).to eq(expected_status)

      if format == :html
        follow_redirect!
        expect(response.body).to include(I18n.t(flash_key)) if flash_key
      else
        expect(response.media_type).to eq('text/vnd.turbo-stream.html') if success
        expect(response).to have_http_status(:unprocessable_entity) unless success
      end
    end
  end

  describe 'PATCH /tasks/:id/update_status' do
    context 'with permitted status' do
      it_behaves_like 'status update', :html, 'completed', 'completed', success: true,
        flash_key: 'notices.task.status_updated'
      it_behaves_like 'status update', :turbo_stream, 'completed', 'completed', success: true
    end

    context 'with not permitted status' do
      it_behaves_like 'status update', :html, 'archived', 'pending', success: false,
        flash_key: 'notices.task.invalid_status'
      it_behaves_like 'status update', :turbo_stream, 'archived', 'pending', success: false
    end
  end
end
