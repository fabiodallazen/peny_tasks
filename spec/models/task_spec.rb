# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { build(:task) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_inclusion_of(:status).in_array(%w[pending completed]) }
  end

  describe 'scopes' do
    let!(:pending_task) { create(:task, status: 'pending') }
    let!(:completed_task) { create(:task, status: 'completed') }

    describe '.pending' do
      it 'returns only tasks with status pending' do
        expect(described_class.pending).to contain_exactly(pending_task)
      end
    end

    describe '.completed' do
      it 'returns only tasks with status completed' do
        expect(described_class.completed).to contain_exactly(completed_task)
      end
    end
  end

  describe '.search' do
    let!(:buy_milk_task) { create(:task, title: 'Buy milk', description: 'Go to the store') }
    let!(:read_book_task) { create(:task, title: 'Read book', description: 'Learn Ruby') }
    let!(:clean_house_task) { create(:task, title: 'Clean house', description: 'Vacuum and dust') }

    context 'when query is present' do
      it 'finds tasks by title' do
        expect(described_class.search('Buy')).to contain_exactly(buy_milk_task)
      end

      it 'finds tasks by description' do
        expect(described_class.search('Ruby')).to contain_exactly(read_book_task)
      end

      it 'finds multiple tasks matching query' do
        expect(described_class.search('o')).to contain_exactly(buy_milk_task, read_book_task, clean_house_task)
      end
    end

    context 'when query is blank' do
      it 'returns nil' do
        expect(described_class.search(nil)).to be_nil
        expect(described_class.search('')).to be_nil
      end
    end
  end
end
