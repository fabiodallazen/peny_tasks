# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskFilter do
  subject(:service) { described_class.new(Task.all, params).call }

  let!(:completed_task) { create(:task, status: 'completed', title: 'Finish report', description: 'Complete report') }
  let!(:pending_task) { create(:task, status: 'pending', title: 'Start project', description: 'Begin new project') }

  context 'when no params are provided' do
    let(:params) { {} }

    it 'returns all tasks' do
      expect(service).to contain_exactly(completed_task, pending_task)
    end
  end

  context 'when filtering by status' do
    let(:params) { { status: 'completed' } }

    it 'returns only tasks with the given status' do
      expect(service).to eq([completed_task])
    end
  end

  context 'when filtering by query' do
    let(:params) { { q: 'project' } }

    it 'returns only tasks matching the query in title or description' do
      expect(service).to eq([pending_task])
    end
  end

  context 'when filtering by status and query' do
    let(:params) { { status: 'pending', q: 'project' } }

    it 'returns tasks that match both filters' do
      expect(service).to eq([pending_task])
    end
  end

  context 'when filtering by status and query with no match' do
    let(:params) { { status: 'completed', q: 'project' } }

    it 'returns an empty result' do
      expect(service).to be_empty
    end
  end
end
