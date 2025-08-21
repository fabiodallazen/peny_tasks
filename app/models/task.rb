# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending completed] }

  scope :pending, -> { where(status: 'pending') }
  scope :completed, -> { where(status: 'completed') }

  def self.search(query)
    where('title ILIKE :q OR description ILIKE :q', q: "%#{query}%") if query.present?
  end
end
