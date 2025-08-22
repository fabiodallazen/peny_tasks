# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskStatusUpdater do
  subject(:service) { described_class.new(task, new_status).call }

  let(:task) { create(:task, status: 'pending') }

  context 'when new_status is permitted' do
    context 'when updating to completed' do
      let(:new_status) { 'completed' }

      it 'updates the task status' do
        expect(service).to be_truthy
        expect(task.reload.status).to eq('completed')
      end
    end

    context 'when updating to pending' do
      let(:new_status) { 'pending' }

      it 'updates the task status' do
        expect(service).to be_truthy
        expect(task.reload.status).to eq('pending')
      end
    end
  end

  context 'when new_status is not permitted' do
    let(:new_status) { 'archived' }

    it 'does not update the task and returns false' do
      expect(service).to be_falsey
      expect(task.reload.status).to eq('pending')
    end
  end
end
