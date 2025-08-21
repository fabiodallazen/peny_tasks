# frozen_string_literal: true

require 'faker'

return unless Rails.env.development?

puts "Seeding tasks..."
Task.destroy_all

statuses = %w[pending completed]

20.times do
  Task.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    status: statuses.sample
  )
end

puts "Created #{Task.count} tasks!"
